//
//  MockBlueskyAgent.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/1/24.
//

import ATProtoKit
import SwiftUI

@Observable
public class MockBlueskyAgent: BlueskyAgent {
    init() {
        let userSession = UserSession(handle: "notakshat.bsky.social",
                                       sessionDID: "0",
                                       isEmailAuthenticationFactorEnabled: false,
                                       accessToken: "0",
                                       refreshToken: "0",
                                       isActive: false,
                                       status: .none)
        super.init(userSession: userSession)
    }
    
    override func fetchUserInfoIfNeeded() async -> AppBskyLexicon.Actor.ProfileViewDetailedDefinition? {
        // TODO @akshatksharma: add failure logic here
        return AppBskyLexicon.Actor.ProfileViewDetailedDefinition(actorDID: "0",
                                                                  actorHandle: "notakshat.bsky.social",
                                                                  displayName: "notakshat",
                                                                  description: "hawk tuah",
                                                                  associated: nil,
                                                                  joinedViaStarterPack: nil,
                                                                  indexedAt: Date(),
                                                                  pinnedPost: nil)
    }
}
