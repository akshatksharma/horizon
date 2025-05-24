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
    var scrollOffset: Binding<CGFloat>? = nil
    var topSpacerHeight: CGFloat? = nil
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if let topSpacerHeight {
                    Spacer()
                        .frame(height: topSpacerHeight)
                }
                ForEach(dataSource.topLevelPosts, id: \.self) { post in
                    VStack(spacing: 0) {
                        FeedViewPost(viewModel: post)
                            .padding(.horizontal, 16)
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 0.5)
                            .padding(.top, 16)
                    }
                }

                if dataSource.hasMorePosts {
                    ProgressView()
                        .frame(height: 50)
                        .onAppear {
                            Task {
                                try await dataSource.fetchPosts(reason: .pagination)
                            }
                        }
                }
            }
            .scrollTargetLayout()
        }
        .refreshable {
            await Task {
                try? await dataSource.fetchPosts(reason: .refresh)
            }.value
        }
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
      geometry.contentOffset.y
        } action: { oldY, newY in
            scrollOffset?.wrappedValue = newY
        }
        .task {
            guard dataSource.posts.isEmpty else { return }
            try? await dataSource.fetchPosts(reason: .coldStart)
        }
        
    }
}
