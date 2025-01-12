//
//  AuthManager.swift
//  Horizon
//
//  Created by Akshat Sharma on 1/11/25.
//

import ATProtoKit
import Foundation
import KeychainSwift
import SwiftUI

public final class AuthManager {
    private let keychain = KeychainSwift()
    
    private var authToken: String? {
        get {
            keychain.get("auth_token")
        }
        set {
            if let newValue {
                keychain.set(newValue, forKey: "auth_token")
            } else {
                keychain.delete("auth_token")
            }
        }
    }
    
    private var refreshToken: String? {
        get {
            keychain.get("refresh_token")
        }
        set {
            if let newValue {
                keychain.set(newValue, forKey: "refresh_token")
            } else {
                keychain.delete("refresh_token")
            }
        }
    }
    
    public init() {}
    
    public func login(handle: String, appPassword: String) async throws -> BlueskyAgent {
        let config = ATProtocolConfiguration(handle: handle, appPassword: appPassword)
        
        try await config.authenticate()
        
        guard let session = config.session else { throw AuthError.authFailed }
        
        self.authToken = session.accessToken
        self.refreshToken = session.refreshToken
        
        return BlueskyAgent(config: config)
    }
    
    public func refresh() async throws -> BlueskyAgent {
        guard let refreshToken else { throw AuthError.refreshTokenExpired }
        let config = ATProtocolConfiguration(handle: "", appPassword: "")
        let session = try await config.refreshSession(by: refreshToken)
        config.session?.pdsURL = "https://bsky.social" // HACK: the refreshSession() implementation currently sets the pdsURL to nil, so need to reset it here until that is fixed
        self.authToken = session.accessToken
        self.refreshToken = session.refreshToken
        
        return BlueskyAgent(config: config)
    }
    
    public func logout() {
        self.authToken = nil
        self.refreshToken = nil
    }
}

enum AuthError: Error {
    case authFailed
    case refreshTokenExpired
}
