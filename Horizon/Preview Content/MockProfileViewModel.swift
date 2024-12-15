//
//  MockProfileViewModel.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/2/24.
//

import ATProtoKit
import Foundation

extension ProfileView.ViewModel {
    static func mock() -> ProfileView.ViewModel {
        let profileDetails = AppBskyLexicon.Actor.ProfileViewDetailedDefinition(actorDID: "0",
                                                                                actorHandle: "notakshat.bsky.social",
                                                                                displayName: "notakshat",
                                                                                description: "hawk tuah",
                                                                                associated: nil,
                                                                                joinedViaStarterPack: nil,
                                                                                indexedAt: Date(),
                                                                                pinnedPost: nil)
        return ProfileView.ViewModel(actorDID: "0",
                                     profileDetails: profileDetails)
    }
}
