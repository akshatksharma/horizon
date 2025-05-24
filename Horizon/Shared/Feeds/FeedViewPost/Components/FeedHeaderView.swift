import SwiftUI
import ATProtoKit

struct FeedHeaderView: View {
    let repostReason: ATUnion.ReasonRepostUnion?
    @State private var repostIconWidth: CGFloat = 0
    
    var body: some View {
        if let repostReason = repostReason {
            switch repostReason {
            case .reasonRepost(let reasonRepostDefinition):
                if let displayName = reasonRepostDefinition.by.displayName {
                    HStack(spacing: 2) {
                        Image(systemName: "repeat")
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                            .readFrame { CGRect in
                                repostIconWidth = CGRect.width
                            }
                        Text("Reposted by \(displayName)")
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                            .lineLimit(1)
                    }
                    .offset(x: -((repostIconWidth / 2) + 2))
                }
            case .reasonPin:
                EmptyView()
            }
        }
    }
} 
