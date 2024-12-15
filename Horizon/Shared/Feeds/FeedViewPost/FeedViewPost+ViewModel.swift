//
//  FeedPostViewModel.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/8/24.
//

import ATProtoKit
import Foundation
import SwiftUI

public extension FeedViewPost {
    class ViewModel: Identifiable {
        
        public var id: String { postURI }
        
        /// The author of the post. This will give the basic details of the post author.
        public let author: AppBskyLexicon.Actor.ProfileViewBasicDefinition
        
        /// The client specified timestamp for when the post was created
        public let createdAt: Date
        
        /// The URI of the post.
        public let postURI: String
        
        /// The text contained in the post.
        public let text: String
        
        /// The number of replies in the post. Optional.
        public let replyCount: Int?

        /// The number of reposts in the post. Optional.
        public let repostCount: Int?

        /// The number of likes in the post. Optional.
        public let likeCount: Int?

        /// The number of quote posts in the post. Optional.
        public let quoteCount: Int?
        
        public init(author: AppBskyLexicon.Actor.ProfileViewBasicDefinition,
                    createdAt: Date,
                    postURI: String,
                    text: String,
                    replyCount: Int?,
                    repostCount: Int?,
                    likeCount: Int?,
                    quoteCount: Int?) {
            self.author = author
            self.createdAt = createdAt
            self.postURI = postURI
            self.text = text
            self.replyCount = replyCount
            self.repostCount = repostCount
            self.likeCount = likeCount
            self.quoteCount = quoteCount
        }
    }
}

// MARK: Conversion Helpers

public extension AppBskyLexicon.Feed.FeedViewPostDefinition {
    // TODO @akshatksharma: make this throwable and handle errors
    func toFeedViewPostViewModel() -> FeedViewPost.ViewModel? {
        switch post.record {
        case .record(let record):
            guard let postRecord = record as? AppBskyLexicon.Feed.PostRecord else { return nil }
            return FeedViewPost.ViewModel(author: post.author,
                                          createdAt: postRecord.createdAt,
                                          postURI: post.postURI,
                                          text: postRecord.text,
                                          replyCount: post.replyCount,
                                          repostCount: post.repostCount,
                                          likeCount: post.likeCount,
                                          quoteCount: post.quoteCount)
        case .unknown(_):
            return nil
        }
    }
}
