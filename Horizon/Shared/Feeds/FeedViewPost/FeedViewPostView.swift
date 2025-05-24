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
    @State private var authorContextHeight: CGFloat = 0
    @Environment(Router.self) private var router
    @Environment(\.currentTab) private var currentTab
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if viewModel.isEmbeddedPost {
                HStack(alignment: .center, spacing: 8) {
                    FeedProfilePictureView(avatarURL: viewModel.author.avatarImageURL, imageLength: authorContextHeight)
                    FeedAuthorContextView(author: viewModel.author)
                        .readFrame { frame in
                            authorContextHeight = frame.height
                        }
                }
                .onTapGesture {
                    router.navigate(to: Routes.profile(authorID: viewModel.author.actorDID), in: currentTab)
                }
                FeedTextView(text: viewModel.text)
                FeedAttachmentView(embed: viewModel.embed)
            } else {
                FeedHeaderView(repostReason: viewModel.repostReason)
                     .offset(CGSize(width: headerOffset, height: 0))
                HStack(alignment: .top) {
                    FeedProfilePictureView(avatarURL: viewModel.author.avatarImageURL, imageLength: 42)
                        .readFrame { frame in
                            headerOffset = frame.maxX
                        }
                        .onTapGesture {
                            router.navigate(to: Routes.profile(authorID: viewModel.author.actorDID), in: currentTab)
                        }
                    VStack(alignment: .leading, spacing: 4) {
                        FeedAuthorContextView(author: viewModel.author)
                            .onTapGesture {
                                router.navigate(to: Routes.profile(authorID: viewModel.author.actorDID), in: currentTab)
                            }
                        FeedTextView(text: viewModel.text)
                        FeedAttachmentView(embed: viewModel.embed)
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    FeedViewPost(viewModel: FeedViewPost.ViewModel(id: UUID().uuidString,
                                                   author: UserModel.mock(),
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
