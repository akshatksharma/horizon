//
//  FeedView.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/14/24.
//

import SwiftUI

struct FeedView: View {
    /// An optional binding to track or control the scroll position of the `ScrollView`.
    /// - If provided, it is used to bind the scroll position, allowing external components
    ///   to control the scroll state. The user interaction on this view will be disabled in this case
    /// - If `nil`, the view handles scrolling on it's own (i.e user interaction is enabled)
    var position: Binding<ScrollPosition>? = nil

    /// Provides post information that the FeedView will render using FeedViewPosts
    @State var dataSource: FeedDataSource
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(dataSource.topLevelPosts) { post in
                    FeedViewPost(viewModel: post)
                        .padding(.bottom, 12)
                }
            }
            .scrollTargetLayout()
        }
        .allowsHitTesting(position == nil)
        .scrollPosition(position ?? .constant(ScrollPosition()))
        .task {
            do {
                try await dataSource.fetchPosts()
            } catch {
                print(error)
            }
        }
    }
}
