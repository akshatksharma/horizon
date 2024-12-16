//
//  FeedPostView.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/8/24.
//

import ATProtoKit
import SwiftUI

public struct FeedViewPost: View {
    let viewModel: ViewModel
    let imageLength = 42.0
    
    public var body: some View {
        HStack(alignment: .top) {
            if let avatarURL = viewModel.author.avatarImageURL {
                AsyncImage(url: avatarURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageLength, height: imageLength)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: imageLength, height: imageLength)
                }
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: imageLength, height: imageLength)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                if let repostReason = viewModel.repostReason {
                    switch repostReason {
                    case .reasonRepost(let reasonRepostDefinition):
                        if let displayName = reasonRepostDefinition.by.displayName {
                            HStack(spacing: 2) {
                                Image(systemName: "repeat")
                                    .foregroundStyle(.secondary)
                                    .font(.footnote)
                                Text("Reposted by \(displayName)")
                                    .foregroundStyle(.secondary)
                                    .font(.footnote)
                            }
                            .padding(.bottom, 2)
                        }
                    case .reasonPin:
                        EmptyView()
                    }
                }
                HStack {
                    if let displayName = viewModel.author.displayName {
                        Text(displayName)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .layoutPriority(-1)
                    }
                    Text("@\(viewModel.author.actorHandle)")
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    
                }
                Text(viewModel.text)
                    .padding(.top, 4)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

#Preview {
    FeedViewPost(viewModel: FeedViewPost.ViewModel(author: UserModel.mock(),
                                                   createdAt: Date(),
                                                   postURI: "",
                                                   text: "i have serious doubts about the existence of god because every time I see him or hear his voice he sounds like someone's uncle",
                                                   reply: nil,
                                                   repostReason: nil,
                                                   replyCount: 10,
                                                   repostCount: 1,
                                                   likeCount: 1000,
                                                   quoteCount: 2))
}
