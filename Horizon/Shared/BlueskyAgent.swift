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
    public var userSession: UserSession? {
        atProtoClient.session
    }
    public internal(set) var userInfo: AppBskyLexicon.Actor.ProfileViewDetailedDefinition?
    public internal(set) var atProtoClient: ATProtoKit
    
    init(config: ATProtocolConfiguration) {
        self.atProtoClient = ATProtoKit(sessionConfiguration: config)
        Task {
            if let refreshToken = userSession?.refreshToken {
                let session = try? await atProtoClient.refreshSession(refreshToken: refreshToken)
                if let session {
                    NSLog(session.refreshToken)
                }
            }
            self.userInfo = await fetchUserInfoIfNeeded()
        }
    }
    
    func fetchUserInfoIfNeeded() async -> AppBskyLexicon.Actor.ProfileViewDetailedDefinition? {
        // TODO @akshatksharma: add failure logic here
        guard userInfo == nil, let sessionDID = atProtoClient.session?.sessionDID else { return nil }
        return try? await atProtoClient.getProfile(sessionDID)
    }
}
