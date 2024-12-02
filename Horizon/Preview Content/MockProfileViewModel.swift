//
//  MockProfileViewModel.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/2/24.
//

import ATProtoKit
import Foundation

extension ProfileView.ViewModel {
    static var mock = ProfileView.ViewModel(actorDID: "0",
                                            profileDef: AppBskyLexicon.Actor.ProfileViewDetailedDefinition(actorDID: "0",
                                                                                                           actorHandle: "notakshat.bsky.social",
                                                                                                           displayName: "notakshat",
                                                                                                           description: "hawk tuah",
                                                                                                           associated: nil,
                                                                                                           joinedViaStarterPack: nil,
                                                                                                           indexedAt: Date(),
                                                                                                           pinnedPost: nil))
}
