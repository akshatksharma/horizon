//
//  ContentView.swift
//  horizon
//
//  Created by Akshat Sharma on 11/17/24.
//

import SwiftUI
import ATProtoKit

struct ContentView: View {
    @Environment(BlueskyAgent.self) private var agent
    
    var body: some View {
        VStack {
            Text(agent.userSession.handle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(BlueskyAgent.mockAgent)
}
