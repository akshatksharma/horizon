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
    public let userSession: UserSession
    public let atProtoClient: ATProtoKit
    
    init(userSession: UserSession) {
        self.userSession = userSession
        self.atProtoClient = ATProtoKit(session: userSession)
    }
    
    static var mockAgent: BlueskyAgent {
        let mockUserSession = UserSession(handle: "?",
                                          sessionDID: "0",
                                          isEmailAuthenticationFactorEnabled: false,
                                          accessToken: "0",
                                          refreshToken: "0",
                                          isActive: false,
                                          status: .none)
        return BlueskyAgent(userSession: mockUserSession)
    }
}
