import SwiftUI
import ATProtoKit

struct FeedAuthorContextView: View {
    let author: UserModel
    
    var body: some View {
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