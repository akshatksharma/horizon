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
    
    init(userSession: UserSession, atProtoClient: ATProtoKit) {
        self.userSession = userSession
        self.atProtoClient = atProtoClient
    }
}
