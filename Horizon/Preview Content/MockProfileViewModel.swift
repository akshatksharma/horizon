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
        return ProfileView.ViewModel(actorDID: "0",
                                     profileDetails: UserModel.mock())
    }
}
