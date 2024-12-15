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
        VStack {
            ForEach(dataSource.posts) { post in
                Text(post.text)
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
