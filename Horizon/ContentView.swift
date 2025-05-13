//
//  ContentView.swift
//  horizon
//
//  Created by Akshat Sharma on 11/17/24.
//

import SwiftUI
import ATProtoKit
import SwiftUIIntrospect

private enum Tabs: Equatable, Hashable {
    case home
    case profile
}

struct ContentView: View {
    @Environment(BlueskyAgent.self) private var agent
    @State private var selectedTab: Tabs = .home
    
    private var profileViewModel: ProfileView.ViewModel {
        // TODO @akshatksharma: fix this optional
        ProfileView.ViewModel(actorDID: agent.atProtoClient.session?.sessionDID ?? "",
                              profileDetails: agent.userInfo?.toUserModel())
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                Group {
                    NavigationStack {
                        HomeView()
                            .navigationTitle("Home")
                            .navigationBarTitleDisplayMode(.large)
                    }
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(Tabs.home)
                    
                    NavigationStack {
                        ProfileView(viewModel: profileViewModel)
                    }
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(Tabs.profile)
                }
            }
            .introspect(.tabView, on: .iOS(.v18)) { controller in
                controller.tabBar.applyBlurBackground()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(MockBlueskyAgent() as BlueskyAgent)
}
