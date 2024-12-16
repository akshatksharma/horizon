//
//  ProfileFeedView.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/8/24.
//

import ATProtoKit
import SwiftUI

struct ProfileFeedView: View {
    @Environment(BlueskyAgent.self) private var agent
    let filter: AppBskyLexicon.Feed.GetAuthorFeed.Filter
    
    var body: some View {
        FeedView(dataSource: FeedDataSource(fetchPostModels: {
            do {
                guard let handle = agent.userSession?.handle else { return [] }
                let myFeed = try await agent.atProtoClient.getAuthorFeed(by: handle, postFilter: filter)
                return myFeed.feed
            } catch {
                print(error)
                return []
            }
        }))
    }
}
   
