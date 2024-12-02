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
    @State var agent: BlueskyAgent?
    @State private var handle: String = ""
    @State private var password: String = ""
    
    private let keychain = KeychainSwift()
    private let userSessionKey = "userSession"
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if let agent {
                    ContentView()
                        .environment(agent)
                } else {
                    VStack(alignment: .leading) {
                        TextField("Username", text: $handle)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Password", text: $password) 
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        
                        Button("Login") {
                            Task {
                                await login(handle: handle, appPassword: password)
                                self.handle = ""
                                self.password = ""
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }
            }.task {
                await loadSession()
            }
        }
    }
    
    private func loadSession() async {
        // Try to load existing session from keychain
        guard let sessionData = keychain.getData(userSessionKey),
              let userSession = try? JSONDecoder().decode(UserSession.self, from: sessionData) else {
            return
        }
        
        self.agent = BlueskyAgent(userSession: userSession)
    }
    
    private func login(handle: String, appPassword: String) async {
        let config = ATProtocolConfiguration(handle: handle, appPassword: appPassword)
        do {
            let userSession = try await config.authenticate()
            // Save session to keychain
            if let sessionData = try? JSONEncoder().encode(userSession) {
                keychain.set(sessionData, forKey: userSessionKey)
            }
            self.agent = BlueskyAgent(userSession: userSession)
        } catch {
            print(error)
        }
    }
    
    private func logout() {
        keychain.delete(userSessionKey)
        self.agent = nil
    }
}
