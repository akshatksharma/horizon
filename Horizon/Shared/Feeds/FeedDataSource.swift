//
//  FeedDatasource.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/14/24.
//

import ATProtoKit
import SwiftUI


enum FetchReason {
    case coldStart
    case pagination
    case refresh
}

@Observable
class FeedDataSource {
    private(set) var posts: [FeedViewPost.ViewModel] = []
    
    var topLevelPosts: [FeedViewPost.ViewModel]  {
        posts.filter { post in post.reply == nil }
    }
    
    var hasMorePosts: Bool {
        if !hasFetched {
            return true
        }
        return cursor != nil
    }
    
    private let fetchPostModels: (String?) async throws -> ([AppBskyLexicon.Feed.FeedViewPostDefinition], String?)
    private var cursor: String?
    private var hasFetched: Bool = false
    
    init(fetchPostModels: @escaping (String?) async throws -> ([AppBskyLexicon.Feed.FeedViewPostDefinition], String?)) {
        self.fetchPostModels = fetchPostModels
    }
    
    func fetchPosts(reason: FetchReason) async throws {
        switch reason {
        case .coldStart, .refresh:
            let (postsModels, nextCursor) = try await fetchPostModels(nil)
            self.cursor = nextCursor
            self.hasFetched = true
            self.posts = postsModels.compactMap {
                $0.toFeedViewPostViewModel()
            }
        case .pagination:
            guard cursor != nil else { return }
            
            let (postsModels, nextCursor) = try await fetchPostModels(cursor)
            self.posts.append(contentsOf: postsModels.compactMap {
                $0.toFeedViewPostViewModel()
            })

            self.cursor = nextCursor
        }
    }
}
