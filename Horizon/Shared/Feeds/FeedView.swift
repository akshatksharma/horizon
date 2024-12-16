//
//  FeedView.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/14/24.
//

import SwiftUI

struct FeedView: View {
    @State var dataSource: FeedDataSource
    
    var body: some View {
        LazyVStack {
            ForEach(dataSource.topLevelPosts) { post in
                FeedViewPost(viewModel: post)
                    .padding(.bottom, 12)
            }
        }.task {
            do {
                try await dataSource.fetchPosts()
            } catch {
                print(error)
            }
        }
    }
}
