//
//  ProfileView.swift
//  Horizon
//
//  Created by Akshat Sharma on 11/25/24.
//

import SwiftUI
import ATProtoKit

struct ProfileView: View {
    @State var viewModel: ViewModel
    @Environment(BlueskyAgent.self) private var agent
    
    @State var safeAreaInsets: EdgeInsets = .init()
    @State private var profileHeaderHeight: CGFloat = 0
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            if let profileDetails = viewModel.profileDetails {
                ZStack(alignment: .top) {
                    ProfileHeaderView(profileDetails: profileDetails, tabs: viewModel.tabs)
                        .readFrame { frame in
                            profileHeaderHeight = frame.size.height
                        }
                        .offset(y: -(safeAreaInsets.top + scrollOffset))
                    ProfileFeedsView(actorDID: viewModel.actorDID,
                                     tabs: viewModel.tabs,
                                     topSpacerHeight: profileHeaderHeight + 6,
                                     scrollOffset: $scrollOffset)
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear)
            }
        }
        .getSafeAreaInsets($safeAreaInsets)
        .task {
            await viewModel.fetchProfileDefIfNeeded(atProtoClient: agent.atProtoClient)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ProfileView(viewModel: ProfileView.ViewModel.mock())
        .environment(MockBlueskyAgent() as BlueskyAgent)
}


