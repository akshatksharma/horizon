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
        GeometryReader { geometry in
            FeedView(dataSource: FeedDataSource(fetchPostModels: { cursor in 
                do {
                    let mainFeed = try await agent.atProtoClient.getTimeline(cursor: cursor)
                    return (mainFeed.feed, mainFeed.cursor)
                } catch {
                    return ([], nil)
                }
            }))
        }
    }
}
