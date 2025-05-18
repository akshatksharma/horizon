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
                    FeedViewPost(viewModel: post)
                        .padding(.bottom, 12)
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
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
      geometry.contentOffset.y
        } action: { oldY, newY in
            scrollOffset?.wrappedValue = newY
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
