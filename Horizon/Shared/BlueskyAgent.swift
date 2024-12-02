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
    public internal(set) var userSession: UserSession
    public internal(set) var userInfo: AppBskyLexicon.Actor.ProfileViewDetailedDefinition?
    public internal(set) var atProtoClient: ATProtoKit
    
    init(userSession: UserSession) {
        self.userSession = userSession
        self.atProtoClient = ATProtoKit(session: userSession)
        Task {
            self.userInfo = await fetchUserInfoIfNeeded()
        }
    }
    
    func fetchUserInfoIfNeeded() async -> AppBskyLexicon.Actor.ProfileViewDetailedDefinition? {
        // TODO @akshatksharma: add failure logic here
        guard userInfo == nil else { return nil }
        return try? await atProtoClient.getProfile(userSession.sessionDID)
    }
}
