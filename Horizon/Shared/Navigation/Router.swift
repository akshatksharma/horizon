//
//  Router.swift
//  horizon
//
//  Created by Akshat Sharma on 11/17/24.
//

import SwiftUI

@Observable
class Router {
    private var navigationPaths: [Tabs: NavigationPath] = [:]
    
    init() {
        // Initialize navigation paths for all tabs
        for tab in Tabs.allCases {
            navigationPaths[tab] = NavigationPath()
        }
    }
    
    // Get the navigation path for a specific tab
    func path(for tab: Tabs) -> Binding<NavigationPath> {
        return Binding(
            get: { self.navigationPaths[tab] ?? NavigationPath() },
            set: { self.navigationPaths[tab] = $0 }
        )
    }
    
    // Navigate to a specific route within a tab
    func navigate<T: Hashable>(to destination: T, in tab: Tabs) {
        navigationPaths[tab]?.append(destination)
    }
    
    // Pop the last view from a tab's navigation stack
    func pop(from tab: Tabs) {
        navigationPaths[tab]?.removeLast()
    }
    
    // Pop to root for a specific tab
    func popToRoot(for tab: Tabs) {
        navigationPaths[tab]?.removeLast(navigationPaths[tab]?.count ?? 0)
    }
    
    // Check if a tab has any navigation stack
    func hasNavigationStack(for tab: Tabs) -> Bool {
        return !(navigationPaths[tab]?.isEmpty ?? true)
    }
    
    // Centralized navigation destination builder
    @ViewBuilder
    func destination(for route: Routes) -> some View {
        switch route {
        case .profile(let authorID):
            ProfileView(viewModel: ProfileView.ViewModel(actorDID: authorID, profileDetails: nil))
        }
    }
} 