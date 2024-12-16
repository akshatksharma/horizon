//
//  horizonApp.swift
//  horizon
//
//  Created by Akshat Sharma on 11/17/24.
//

import SwiftUI
import ATProtoKit
import KeychainSwift

@main
struct HorizonApp: App {
    private enum SessionStatus {
        case authenticated(BlueskyAgent)
        case notAuthenticated
        case loading
    }
    
    @State private var sessionStatus: SessionStatus = .loading
    private let keychain = KeychainSwift()
//    private let refreshTokenKey = "horizon-refreshToken"
    private let userSessionKey = "horizon-userSession"
    private let handleKey = "horizon-handle"
    private let appPasswordKey = "horizon-appPassword"
    
    var body: some Scene {
        WindowGroup {
            VStack(alignment: .leading) {
                switch sessionStatus {
                case .authenticated(let agent):
                    ContentView()
                        .environment(agent)
                case .notAuthenticated:
                    LoginView() { handle, password in
                        await login(handle: handle, appPassword: password)
                    }
                case .loading:
                    ProgressView()
                }
            }.task {
                await loadSession()
            }
        }
    }
    
    private func loadSession() async {
        guard let sessionData = keychain.getData(userSessionKey),
              let handle = keychain.get(handleKey),
              let appPassword = keychain.get(appPasswordKey),
              let userSession = try? JSONDecoder().decode(UserSession.self, from: sessionData) else {
            self.sessionStatus = .notAuthenticated
            return
        }

        let config = ATProtocolConfiguration(handle: handle, appPassword: appPassword)
        config.session = userSession
        self.sessionStatus = .authenticated(BlueskyAgent(config: config))
//        self.sessionStatus = .notAuthenticated
    }
    
    private func login(handle: String, appPassword: String) async {
        let config = ATProtocolConfiguration(handle: handle, appPassword: appPassword)
        do {
            try await config.authenticate()
            if let userSession = config.session, let sessionData = try? JSONEncoder().encode(userSession) {
                keychain.set(sessionData, forKey: userSessionKey)
                keychain.set(handle, forKey: handleKey)
                keychain.set(appPassword, forKey: appPasswordKey)
            }
            self.sessionStatus = .authenticated(BlueskyAgent(config: config))
        } catch {
            self.sessionStatus = .notAuthenticated
            print(error)
        }
    }
    
    private func logout() {
        keychain.delete(userSessionKey)
        self.sessionStatus = .notAuthenticated
    }
}
