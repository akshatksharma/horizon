//
//  UserModel.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/15/24.
//

import ATProtoKit
import Foundation

public class UserModel {
    
    /// The decentralized identifier (DID) of the user.
    public let actorDID: String

    /// The unique handle of the user.
    public let actorHandle: String

    /// The display name of the user. Optional.
    ///
    /// - Important: Current maximum length is 64 characters.
    public let displayName: String?

    /// The avatar image URL of the user's profile. Optional.
    public let avatarImageURL: URL?

    /// The associated profile view. Optional.
    public let associated: AppBskyLexicon.Actor.ProfileAssociatedDefinition?

    /// The list of metadata relating to the requesting account's relationship with the subject
    /// account. Optional.
    public let viewer: AppBskyLexicon.Actor.ViewerStateDefinition?

    /// An array of labels created by the user. Optional.
    public let labels: [ComAtprotoLexicon.Label.LabelDefinition]?

    /// The date and time the profile was created. Optional.
    public let createdAt: Date?

    /// The description of the user's profile. Optional.
    ///
    /// - Important: Current maximum length is 256 characters.
    public var description: String?

    /// The banner image URL of a user's profile. Optional.
    public var bannerImageURL: URL?

    /// The number of followers a user has. Optional.
    public var followerCount: Int?

    /// The number of accounts the user follows. Optional.
    public var followCount: Int?

    /// The number of posts the user has. Optional.
    public var postCount: Int?

    /// The date the profile was last indexed. Optional.
    public let indexedAt: Date?

    /// A post record that's pinned to the profile. Optional.
    public let pinnedPost: ComAtprotoLexicon.Repository.StrongReference?
    
    init(actorDID: String,
         actorHandle: String,
         displayName: String? = nil,
         avatarImageURL: URL? = nil,
         associated: AppBskyLexicon.Actor.ProfileAssociatedDefinition? = nil,
         viewer: AppBskyLexicon.Actor.ViewerStateDefinition? = nil,
         labels: [ComAtprotoLexicon.Label.LabelDefinition]? = nil,
         createdAt: Date? = nil,
         description: String? = nil,
         bannerImageURL: URL? = nil,
         followerCount: Int? = nil,
         followCount: Int? = nil,
         postCount: Int? = nil,
         indexedAt: Date? = nil,
         pinnedPost: ComAtprotoLexicon.Repository.StrongReference? = nil) {
        self.actorDID = actorDID
        self.actorHandle = actorHandle
        self.displayName = displayName
        self.avatarImageURL = avatarImageURL
        self.associated = associated
        self.viewer = viewer
        self.labels = labels
        self.createdAt = createdAt
        self.description = description
        self.bannerImageURL = bannerImageURL
        self.followerCount = followerCount
        self.followCount = followCount
        self.postCount = postCount
        self.indexedAt = indexedAt
        self.pinnedPost = pinnedPost
    }
}

public extension AppBskyLexicon.Actor.ProfileViewBasicDefinition {
    func toUserModel() -> UserModel {
        UserModel(actorDID: actorDID,
                  actorHandle: actorHandle,
                  displayName: displayName,
                  avatarImageURL: avatarImageURL,
                  associated: associated,
                  viewer: viewer,
                  labels: labels,
                  createdAt: createdAt)
    }
}

public extension AppBskyLexicon.Actor.ProfileViewDetailedDefinition {
    func toUserModel() -> UserModel {
        UserModel(actorDID: actorDID,
                  actorHandle: actorHandle,
                  displayName: displayName,
                  avatarImageURL: avatarImageURL,
                  associated: associated,
                  viewer: viewer,
                  labels: labels,
                  createdAt: indexedAt,
                  description: description,
                  bannerImageURL: bannerImageURL,
                  followerCount: followerCount,
                  followCount: followCount,
                  postCount: postCount,
                  indexedAt: indexedAt,
                  pinnedPost: pinnedPost)
    }
}
