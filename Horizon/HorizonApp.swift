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
    
    @Environment(\.scenePhase) var scenePhase
    @State private var sessionStatus: SessionStatus = .loading
    @State private var authManager = AuthManager()
    @State private var router = Router()

    var body: some Scene {
        WindowGroup {
            VStack(alignment: .leading) {
                switch sessionStatus {
                case .authenticated(let agent):
                    ContentView()
                        .environment(agent)
                        .environment(router)
                case .notAuthenticated:
                    LoginView() { handle, password in
                        do {
                            sessionStatus = .loading
                            let agent = try await authManager.login(handle: handle, appPassword: password)
                            sessionStatus = .authenticated(agent)
                        } catch {
                            sessionStatus = .notAuthenticated
                        }
                    }
                case .loading:
                    EmptyView()
                }
            }.task(id: scenePhase) {
                guard scenePhase == .active else { return }
                do {
                    let agent = try await authManager.refresh()
                    sessionStatus = .authenticated(agent)
                } catch {
                    sessionStatus = .notAuthenticated
                }
            }
        }
    }
}
