import SwiftUI

struct FeedProfilePictureView: View {
    let avatarURL: URL?
    let imageLength: CGFloat
    let authorDID: String?
    
    @Environment(Router.self) private var router
    @Environment(\.currentTab) private var currentTab
    
    var body: some View {
        Group {
            if let avatarURL = avatarURL {
                AsyncImage(url: avatarURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageLength, height: imageLength)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: imageLength, height: imageLength)
                }
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: imageLength, height: imageLength)
            }
        }
        .onTapGesture {
            if let authorDID = authorDID {
                router.navigate(to: Routes.profile(authorID: authorDID), in: currentTab)
            }
        }
    }
} 
