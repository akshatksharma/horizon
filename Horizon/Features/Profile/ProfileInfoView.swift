//
//  ProfileHeader.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/1/24.
//

import ATProtoKit
import Shimmer
import SwiftUI

struct ProfileInfoView: View {
    let profileDetails: UserModel
    let imageLength = 100.0
    
    var body: some View {
        VStack(alignment: .leading) {
            profileView
            handleView
            descriptionView
        }.padding(.horizontal)
    }
    
    // MARK: Subviews
    
    @ViewBuilder
    private var profileView: some View {
        if let avatarImageURL = profileDetails.avatarImageURL {
            AsyncImage(url: avatarImageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: imageLength, height: imageLength)
                case .failure(_):
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: imageLength, height: imageLength)
                default:
                    Circle()
                        .fill(Color.gray)
                        .frame(width: imageLength, height: imageLength)
                }
            }
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: imageLength, height: imageLength)
        }
    }
    
    @ViewBuilder
    private var handleView: some View {
        if let displayName = profileDetails.displayName {
            Text(displayName)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(profileDetails.actorHandle)
        } else {
            Text(profileDetails.actorHandle)
                .font(.title)
                .fontWeight(.bold)
        }
    }
    
    @ViewBuilder
    private var descriptionView: some View {
        if let description = profileDetails.description {
            Text(description)
                .font(.subheadline)
                .lineLimit(2)
                .padding(.top, 8)
        }
    }
}
