//
//  ProfilePostsView.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/8/24.
//

import ATProtoKit
import SwiftUI

struct ProfileFeedsView: View {
    let actorDID: String
    let tabs: [AppBskyLexicon.Feed.GetAuthorFeed.Filter]
    @State private var selectedTab: AppBskyLexicon.Feed.GetAuthorFeed.Filter = .postsWithNoReplies
    
    var body: some View {
        LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
            Section {
                feedContainer
            } header: {
                tabBar
            }
        }
    }
    
    // MARK: Subviews
    
    @ViewBuilder
    private var tabBar: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(tabs) { tab in
                    Group {
                        Button(action: {
                            withAnimation {
                                selectedTab = tab
                            }
                        }) {
                            Text(tab.displayTitle)
                                .foregroundColor(tab == selectedTab ? .primary : .gray)
                                .padding(.bottom, 8)
                        }
                    }
                }
            }
        }
        .contentMargins(.leading, 16)
        .background(Color(UIColor.systemBackground))
    }
    
    @ViewBuilder
    private var feedContainer: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(tabs) { tab in
                    ProfileFeedView(filter: tab)
                        .containerRelativeFrame(.horizontal,
                                             count: 1,
                                             spacing: 0)
                        .id(tab)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

extension AppBskyLexicon.Feed.GetAuthorFeed.Filter: @retroactive Identifiable {
    public var id: String {
        rawValue
    }
    
    public var displayTitle: String {
        switch self {
        case .postAndAuthorThreads:
            "Threads"
        case .postsWithMedia:
            "Media"
        case .postsWithNoReplies:
            "Posts"
        case .postsWithReplies:
            "Replies"
        }
    }
}
