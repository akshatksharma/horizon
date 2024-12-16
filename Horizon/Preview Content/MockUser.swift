//
//  MockUser.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/15/24.
//

import ATProtoKit
import Foundation

extension UserModel {
    static func mock() -> UserModel {
        return UserModel(actorDID: "0",
                         actorHandle: "notakshat.bsky.social",
                         displayName: "notakshatnotakshatnotakshatnotakshatnotakshatnotakshat",
                         description: "?????????????????")
    }
}
