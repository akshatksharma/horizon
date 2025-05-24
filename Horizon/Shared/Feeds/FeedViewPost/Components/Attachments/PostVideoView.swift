import SwiftUI
import ATProtoKit
import AVKit

struct PostVideoView: View {
    let video: AppBskyLexicon.Embed.VideoDefinition.View
    
    private struct Constants {
        static let maxHeight = 200.0
        static let maxWidth = 400.0
        static let playButtonSize = 32.0
    }
    
    var body: some View {
        ZStack {
            if let thumbnailURL = video.thumbnailImageURL {
                AsyncImage(url: URL(string: thumbnailURL)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: calculatedHeight)
                            .cornerRadius(12)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: Constants.maxHeight)
                            .cornerRadius(12)
                            .overlay(
                                Image(systemName: "play.fill")
                                    .font(.system(size: Constants.playButtonSize))
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)
                            )
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: calculatedHeight)
                            .cornerRadius(12)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: calculatedHeight)
                    .cornerRadius(12)
            }
        }
    }

    // Calculate height based on aspect ratio, with fallback to maxHeight
    private var calculatedHeight: CGFloat {
        guard let aspectRatio = video.aspectRatio else {
            return Constants.maxHeight
        }
        
        let ratio = CGFloat(aspectRatio.height) / CGFloat(aspectRatio.width)
        let calculatedHeight = Constants.maxWidth * ratio
        
        // Ensure we don't exceed maxHeight
        return min(calculatedHeight, Constants.maxHeight)
    }
    
}
