import SwiftUI
import ATProtoKit
import AVKit

struct PostVideoView: View {
    let video: AppBskyLexicon.Embed.VideoDefinition.View
    
    var body: some View {
        ZStack {
            if let thumbnailURL = video.thumbnailImageURL {
                AsyncImage(url: URL(string: thumbnailURL)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(maxWidth: getMaxWidth(using: video.aspectRatio), minHeight: Constants.maxImageHeight)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(CGSize(width: video.aspectRatio?.width ?? 16, height: video.aspectRatio?.height ?? 9), contentMode: .fit)
                            .frame(maxWidth: getMaxWidth(using: video.aspectRatio), minHeight: Constants.maxImageHeight)
                            .overlay(
                                Image(systemName: "play.fill")
                                    .font(.system(size: Constants.playButtonSize))
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)
                            )
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(maxWidth: getMaxWidth(using: video.aspectRatio), minHeight: Constants.maxImageHeight)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(maxWidth: getMaxWidth(using: video.aspectRatio), minHeight: Constants.maxImageHeight)
            }
        }
    }

    private struct Constants {
        static let maxImageHeight = 200.0
        static let playButtonSize = 32.0
        static let defaultAspectRatio = 16.0 / 9.0
    }

    private func getMaxWidth(using aspectRatio: AppBskyLexicon.Embed.AspectRatioDefinition?) -> CGFloat {
        guard let aspectRatio = aspectRatio else {
            return Constants.maxImageHeight * Constants.defaultAspectRatio
        }
        return Constants.maxImageHeight * CGFloat(aspectRatio.width) / CGFloat(aspectRatio.height)
    }
}
