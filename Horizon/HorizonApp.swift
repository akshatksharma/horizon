//
//  horizonApp.swift
//  horizon
//
//  Created by Akshat Sharma on 11/17/24.
//

import SwiftUI
import ATProtoKit

@main
struct HorizonApp: App {
    @State var agent: BlueskyAgent?
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if let agent {
                    ContentView()
                        .environment(agent)
                } else {
                    ProgressView()
                }
            }.task {
                let config = ATProtocolConfiguration(handle: "?", appPassword: "?")
                do {
                    let userSession = try await config.authenticate()
                    let atProtoClient = ATProtoKit(session: userSession)
                    self.agent = BlueskyAgent(userSession: userSession, atProtoClient: atProtoClient)
                } catch {
                    print(error)
                }
            }
        }
    }
}
