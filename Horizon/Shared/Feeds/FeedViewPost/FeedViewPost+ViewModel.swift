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
    class ViewModel: Identifiable, Hashable {
        
        public var id: String { postURI }
        
        /// The author of the post. This will give the basic details of the post author.
        public let author: UserModel
        
        /// The client specified timestamp for when the post was created
        public let createdAt: Date
        
        /// The URI of the post.
        public let postURI: String
        
        /// The text contained in the post.
        public let text: String
        
        /// The references to posts when replying. Optional.
        public var reply: AppBskyLexicon.Feed.ReplyReferenceDefinition?
        
        /// The user who reposted the post. Optional.
        public var repostReason: ATUnion.ReasonRepostUnion?
        
        /// The number of replies in the post. Optional.
        public let replyCount: Int?

        /// The number of reposts in the post. Optional.
        public let repostCount: Int?

        /// The number of likes in the post. Optional.
        public let likeCount: Int?

        /// The number of quote posts in the post. Optional.
        public let quoteCount: Int?
        
        public init(author: UserModel,
                    createdAt: Date,
                    postURI: String,
                    text: String,
                    reply: AppBskyLexicon.Feed.ReplyReferenceDefinition?,
                    repostReason: ATUnion.ReasonRepostUnion?,
                    replyCount: Int?,
                    repostCount: Int?,
                    likeCount: Int?,
                    quoteCount: Int?) {
            self.author = author
            self.createdAt = createdAt
            self.postURI = postURI
            self.text = text
            self.reply = reply
            self.repostReason = repostReason
            self.replyCount = replyCount
            self.repostCount = repostCount
            self.likeCount = likeCount
            self.quoteCount = quoteCount
        }
        
        // MARK: - Equatable
        
        public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
            return lhs.postURI == rhs.postURI &&
                   lhs.author == rhs.author &&
                   lhs.createdAt == rhs.createdAt &&
                   lhs.text == rhs.text &&
                   lhs.reply == rhs.reply && // Assuming ReplyReferenceDefinition is Equatable
                   lhs.repostReason == rhs.repostReason && // Assuming ReasonRepostUnion is Equatable
                   lhs.replyCount == rhs.replyCount &&
                   lhs.repostCount == rhs.repostCount &&
                   lhs.likeCount == rhs.likeCount &&
                   lhs.quoteCount == rhs.quoteCount
        }

        // MARK: - Hashable
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(postURI)
            hasher.combine(author)
            hasher.combine(createdAt)
            hasher.combine(text)
            hasher.combine(reply) // Assuming ReplyReferenceDefinition is Hashable
            hasher.combine(repostReason) // Assuming ReasonRepostUnion is Hashable
            hasher.combine(replyCount)
            hasher.combine(repostCount)
            hasher.combine(likeCount)
            hasher.combine(quoteCount)
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
            return FeedViewPost.ViewModel(author: post.author.toUserModel(),
                                          createdAt: postRecord.createdAt,
                                          postURI: post.uri,
                                          text: postRecord.text,
                                          reply: reply,
                                          repostReason: reason,
                                          replyCount: post.replyCount,
                                          repostCount: post.repostCount,
                                          likeCount: post.likeCount,
                                          quoteCount: post.quoteCount)
        case .unknown(_):
            return nil
        }
    }
}
