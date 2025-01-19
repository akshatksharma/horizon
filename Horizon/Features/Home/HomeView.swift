//
//  HomeView.swift
//  Horizon
//
//  Created by Akshat Sharma on 11/25/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(BlueskyAgent.self) private var agent
    
    var body: some View {
        FeedView(dataSource: FeedDataSource(fetchPostModels: {
            do {
                let mainFeed = try await agent.atProtoClient.getTimeline()
                return mainFeed.feed
            } catch {
                return []
            }
        }))
    }
}
    
