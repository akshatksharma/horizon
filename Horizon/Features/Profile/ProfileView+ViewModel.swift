//
//  ProfileView+ViewModel.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/2/24.
//

import ATProtoKit
import SwiftUI

extension ProfileView {
    @Observable
    class ViewModel {
        let actorDID: String
        private(set) var profileDef: AppBskyLexicon.Actor.ProfileViewDetailedDefinition?
        
        init(actorDID: String, profileDef: AppBskyLexicon.Actor.ProfileViewDetailedDefinition? = nil) {
            self.actorDID = actorDID
            self.profileDef = profileDef
        }
        
        func fetchProfileDefIfNeeded(atProtoClient: ATProtoKit) async {
            guard profileDef == nil else { return }
            // TODO @akshatksharma: handle error
            self.profileDef = try? await atProtoClient.getProfile(actorDID)
        }
    }
}
