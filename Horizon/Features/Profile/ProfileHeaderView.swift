//
//  ProfileHeader.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/1/24.
//

import ATProtoKit
import Shimmer
import SwiftUI

struct ProfileHeaderView: View {
    let profileDef: AppBskyLexicon.Actor.ProfileViewDetailedDefinition
    let imageLength = 100.0
    
    var body: some View {
        VStack(alignment: .leading) {
            if let avatarImageURL = profileDef.avatarImageURL {
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
            
            if let displayName = profileDef.displayName {
                Text(displayName)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(profileDef.actorHandle)
            } else {
                Text(profileDef.actorHandle)
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            if let description = profileDef.description {
                Text(description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .padding(.top, 8)
            }
        }
    }
}
