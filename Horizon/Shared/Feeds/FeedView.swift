//
//  FeedView.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/14/24.
//

import SwiftUI

struct FeedView: View {
    /// Provides post information that the FeedView will render using FeedViewPosts
    @State var dataSource: FeedDataSource
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(dataSource.topLevelPosts) { post in
                    FeedViewPost(viewModel: post)
                        .padding(.bottom, 12)
                }
                
                // Add a spacer at the end that triggers pagination when visible
                Color.clear
                    .frame(height: 50)
                    .onAppear {
                        Task {
                            do {
                                try await dataSource.fetchPosts(reason: .pagination)
                            } catch {
                                print(error)
                            }
                        }
                    }
            }
            .scrollTargetLayout()
        }
        .task {
            do {
                try await dataSource.fetchPosts(reason: .coldStart)
            } catch {
                print(error)
            }
        }
    }
}
