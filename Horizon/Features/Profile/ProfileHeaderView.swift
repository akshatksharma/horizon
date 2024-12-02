//
//  ProfileHeader.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/1/24.
//

import ATProtoKit
import SwiftUI

struct ProfileHeaderView: View {
    let profileDef: AppBskyLexicon.Actor.ProfileViewDetailedDefinition
    
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
                            .frame(width: 100, height: 100)
                    case .failure(_):
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                    default:
                        ProgressView()
                    }
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
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
