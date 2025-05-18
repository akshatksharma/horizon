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
    @State private var headerOffset: CGFloat = 0
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FeedHeaderView(repostReason: viewModel.repostReason)
                .offset(CGSize(width: headerOffset, height: 0))
            HStack(alignment: .top) {
                FeedProfilePictureView(avatarURL: viewModel.author.avatarImageURL)
                    .readFrame { frame in
                        headerOffset = frame.maxX
                    }
                VStack(alignment: .leading, spacing: 4) {
                    FeedAuthorContextView(author: viewModel.author)
                    FeedTextView(text: viewModel.text)
                    FeedAttachmentView(embed: viewModel.embed)
                }
                Spacer()
            }
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
                                                   embed: nil,
                                                   reply: nil,
                                                   repostReason: nil,
                                                   replyCount: 10,
                                                   repostCount: 1,
                                                   likeCount: 1000,
                                                   quoteCount: 2))
}
