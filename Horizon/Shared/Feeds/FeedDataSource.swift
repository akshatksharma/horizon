//
//  FeedDatasource.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/14/24.
//

import ATProtoKit
import SwiftUI

@Observable
class FeedDataSource {
    
    private(set) var posts: [FeedViewPost.ViewModel] = []
    
    private let fetchPostModels: () async throws -> [AppBskyLexicon.Feed.FeedViewPostDefinition]
    
    init(fetchPostModels: @escaping () async throws -> [AppBskyLexicon.Feed.FeedViewPostDefinition]) {
        self.fetchPostModels = fetchPostModels
    }
    
    func fetchPosts() async throws {
        let postsModels = try await fetchPostModels()
        
        self.posts = postsModels.compactMap {
            $0.toFeedViewPostViewModel()
        }
        
        // handle pagination (in the fetcher)
    }
}
