//
//  HomeView.swift
//  Horizon
//
//  Created by Akshat Sharma on 11/25/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(BlueskyAgent.self) private var agent
    @State private var isScrollingUp = false
    @State private var lastScrollY: CGFloat = 0
    private let topPadding = 48.0
    
    var body: some View {
        GeometryReader { geometry in
            FeedView(dataSource: FeedDataSource(fetchPostModels: { cursor in 
                do {
                    let mainFeed = try await agent.atProtoClient.getTimeline(cursor: cursor)
                    return (mainFeed.feed, mainFeed.cursor)
                } catch {
                    return ([], nil)
                }
            }))
//            .safeAreaInset(edge: .top, spacing: -topPadding) {
//                headerView(width: geometry.size.width, height: topPadding + geometry.safeAreaInsets.top)
//            }
            .onScrollGeometryChange(for: CGPoint.self, of: { scrollGeometry in
                scrollGeometry.contentOffset
            }, action: { oldValue, newValue in
                withAnimation(.easeInOut(duration: 0.3)) {
                    if newValue.y > 0 { // Only track scroll direction when not at the top
                        isScrollingUp = newValue.y < lastScrollY
                    }
                    lastScrollY = newValue.y
                }
            })
        }
    }
    
    // MARK: Subviews
    
    @ViewBuilder
    private func headerView(width: CGFloat, height: CGFloat) -> some View {
        VStack {
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    Text("Discover")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.bottom, 4)
        }
        .background(Color(UIColor.systemBackground))
        .opacity(lastScrollY <= 0 || isScrollingUp ? 1 : 0)
        .frame(width: width, height: height)
        .ignoresSafeArea(.container, edges: .top)
    }
}
