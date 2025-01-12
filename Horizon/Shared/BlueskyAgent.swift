//
//  BlueskyAgent.swift
//  horizon
//
//  Created by Akshat Sharma on 11/17/24.
//

import Foundation
import ATProtoKit

@Observable
public class BlueskyAgent {
    public internal(set) var userInfo: AppBskyLexicon.Actor.ProfileViewDetailedDefinition?
    public internal(set) var atProtoClient: ATProtoKit
    
    init(config: ATProtocolConfiguration) {
        self.atProtoClient = ATProtoKit(sessionConfiguration: config)
        Task {
            self.userInfo = await fetchUserInfoIfNeeded()
        }
    }
    
    func fetchUserInfoIfNeeded() async -> AppBskyLexicon.Actor.ProfileViewDetailedDefinition? {
        // TODO @akshatksharma: add failure logic here
        guard userInfo == nil, let sessionDID = atProtoClient.session?.sessionDID else { return nil }
        return try? await atProtoClient.getProfile(for: sessionDID)
    }
}
