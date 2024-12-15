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
    private let userSessionKey = "userSession"
    
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
        // Try to load existing session from keychain
//        guard let sessionData = keychain.getData(userSessionKey),
//              let userSession = try? JSONDecoder().decode(UserSession.self, from: sessionData) else {
//            self.sessionStatus = .notAuthenticated
//            return
//        }
        
//        self.sessionStatus = .authenticated(BlueskyAgent(userSession: userSession))
        self.sessionStatus = .notAuthenticated
    }
    
    private func login(handle: String, appPassword: String) async {
        let config = ATProtocolConfiguration(handle: handle, appPassword: appPassword)
        do {
            try await config.authenticate()
            // Save session to keychain
//            if let sessionData = try? JSONEncoder().encode(userSession) {
//                keychain.set(sessionData, forKey: userSessionKey)
//            }
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
