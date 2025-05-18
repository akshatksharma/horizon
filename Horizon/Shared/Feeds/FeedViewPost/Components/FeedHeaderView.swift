import SwiftUI
import ATProtoKit

struct FeedHeaderView: View {
    let repostReason: ATUnion.ReasonRepostUnion?
    
    var body: some View {
        if let repostReason = repostReason {
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
    }
} 