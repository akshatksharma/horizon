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
        private(set) var profileDetails: UserModel? // could be passed in, or might need to be fetched
        private(set) var tabs: [AppBskyLexicon.Feed.GetAuthorFeed.Filter]
        
        init(actorDID: String,
             profileDetails: UserModel? = nil) {
            self.actorDID = actorDID
            self.profileDetails = profileDetails
            self.tabs = [.postsWithNoReplies]
        }
        
        func fetchProfileDefIfNeeded(atProtoClient: ATProtoKit) async {
            guard profileDetails == nil else { return }
            // TODO @akshatksharma: handle error
            self.profileDetails = try? await atProtoClient.getProfile(for: actorDID).toUserModel()
        }
    }
}
