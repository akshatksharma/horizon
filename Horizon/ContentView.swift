//
//  ContentView.swift
//  horizon
//
//  Created by Akshat Sharma on 11/17/24.
//

import SwiftUI
import ATProtoKit
import SwiftUIIntrospect

struct ContentView: View {
    @Environment(BlueskyAgent.self) private var agent
    @Environment(Router.self) private var router
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
                    NavigationStack(path: router.path(for: .home)) {
                        HomeView()
                            .navigationTitle("Home")
                            .navigationBarTitleDisplayMode(.large)
                            .navigationDestination(for: Routes.self) { route in
                                router.destination(for: route)
                            }
                    }
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(Tabs.home)
                    
                    NavigationStack(path: router.path(for: .profile)) {
                        ProfileView(viewModel: profileViewModel)
                            .navigationDestination(for: Routes.self) { route in
                                router.destination(for: route)
                            }
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
        .environment(Router())
}
