import SwiftUI

struct FeedProfilePictureView: View {
    let avatarURL: URL?
    let imageLength: CGFloat
    
    var body: some View {
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
} 
