import SwiftUI
import ATProtoKit

struct FeedHeaderView: View {
    let author: UserModel
    let repostReason: ATUnion.ReasonRepostUnion?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
            HStack {
                if let displayName = author.displayName {
                    Text(displayName)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
                Text("@\(author.actorHandle)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .layoutPriority(-1)
            }
        }
    }
} 
