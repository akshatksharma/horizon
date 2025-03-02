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
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ZStack(alignment: .top) {
                    ScrollView(.vertical) {
                        VStack(alignment: .leading) {
                            if let profileDetails = viewModel.profileDetails {
                                ProfileInfoView(profileDetails: profileDetails)
                                ProfileFeedsView(actorDID: viewModel.actorDID, tabs: viewModel.tabs)
                                    .padding(.vertical, 32)
                            } else {
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.clear)
                            }
                        }
                        .scrollTargetLayout()
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color(UIColor.systemBackground), for: .navigationBar)
                        .toolbarBackground(.automatic, for: .navigationBar)
                        .task {
                            await viewModel.fetchProfileDefIfNeeded(atProtoClient: agent.atProtoClient)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .safeAreaPadding(.top, 64)
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileView.ViewModel.mock())
        .environment(MockBlueskyAgent() as BlueskyAgent)
}


