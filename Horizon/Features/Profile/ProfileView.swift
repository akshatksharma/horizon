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
    @State private var headerOpacity: CGFloat = 0.0
    
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
                    .onScrollGeometryChange(for: CGPoint.self,
                                            of: { scrollGeometry in
                        scrollGeometry.contentOffset
                    }, action: { oldValue, newValue in
                        let headerHeight = reader.safeAreaInsets.top
                        headerOpacity = max(0, (newValue.y - (headerHeight) / 4) / headerHeight)
                    })
                    
                    // floating header view
                    if let profileDetails = viewModel.profileDetails {
                        ProfileHeaderView(actorName: profileDetails.displayName ?? profileDetails.actorHandle)
                            .frame(width: reader.size.width, height: reader.safeAreaInsets.top)
                            .background(Color(UIColor.systemBackground))
                            .ignoresSafeArea(.all, edges: .top)
                            .opacity(headerOpacity)
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


