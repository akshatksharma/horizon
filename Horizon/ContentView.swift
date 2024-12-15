//
//  ContentView.swift
//  horizon
//
//  Created by Akshat Sharma on 11/17/24.
//

import SwiftUI
import ATProtoKit

private enum Tabs: Equatable, Hashable {
    case home
    case profile
}

struct ContentView: View {
    @Environment(BlueskyAgent.self) private var agent
    @State private var selectedTab: Tabs = .home
    
    private var profileViewModel: ProfileView.ViewModel {
        // TODO @akshatksharma: fix this optional
        ProfileView.ViewModel(actorDID: agent.userSession?.sessionDID ?? "",
                              profileDetails: agent.userInfo)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                Tab("Home", systemImage: "house", value: .home) {
                    HomeView()
                }
                Tab("Profile", systemImage: "person", value: .profile) {
                    ProfileView(viewModel: profileViewModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(MockBlueskyAgent() as BlueskyAgent)
}
