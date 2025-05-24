//
//  HomeView.swift
//  Horizon
//
//  Created by Akshat Sharma on 11/25/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(BlueskyAgent.self) private var agent
    @Environment(\.currentTab) private var currentTab
    
    var body: some View {
        let dataSource = FeedDataSource(fetchPostModels: { cursor in
            do {
                let mainFeed = try await agent.atProtoClient.getTimeline(limit: 10, cursor: cursor)
                return (mainFeed.feed, mainFeed.cursor)
            } catch {
                return ([], nil)
            }
        })
        FeedView(dataSource: dataSource)
    }
}
