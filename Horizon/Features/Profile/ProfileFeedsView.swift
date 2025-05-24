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
    let tabs: [AppBskyLexicon.Feed.GetAuthorFeed.Filter] // TODO @akshatksharma: use these tabs
    let topSpacerHeight: CGFloat
    @Binding var scrollOffset: CGFloat
    
    @Environment(BlueskyAgent.self) private var agent
    @State private var selectedTab: AppBskyLexicon.Feed.GetAuthorFeed.Filter = .postsWithNoReplies
    
    var body: some View {
        VStack {
            let tab = tabs[0] // only using the first tab for now
            let dataSource = FeedDataSource(fetchPostModels: { cursor in
                do {
                    let myFeed = try await agent.atProtoClient.getAuthorFeed(by: actorDID, cursor: cursor, postFilter: tab)
                    return (myFeed.feed, myFeed.cursor)
                } catch {
                    print(error)
                    return ([], nil)
                }
            })
            FeedView(dataSource: dataSource, scrollOffset: $scrollOffset, topSpacerHeight: topSpacerHeight)
                .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                .id(tab)
        }
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
        case .postsWithVideo:
            "Videos"
        }
    }
}
