import SwiftUI
import ATProtoKit

struct FeedAuthorContextView: View {
    let author: UserModel
    
    @Environment(Router.self) private var router
    @Environment(\.currentTab) private var currentTab
    
    var body: some View {
        HStack {
            if let displayName = author.displayName {
                Text(displayName)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .layoutPriority(1)
            }
            Text("@\(author.actorHandle)")
                .font(.callout)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .layoutPriority(-1)
        }
        .onTapGesture {
            router.navigate(to: Routes.profile(authorID: author.actorDID), in: currentTab)
        }
    }
} 