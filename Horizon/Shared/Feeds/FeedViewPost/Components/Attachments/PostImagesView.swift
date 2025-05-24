import SwiftUI
import ATProtoKit

struct PostImagesView: View {
    let images: [AppBskyLexicon.Embed.ImagesDefinition.ViewImage]
    
    struct Constants {
        static let maxHeight: CGFloat = 200
        static let maxWidth: CGFloat = 400
    }
        
    var body: some View {
        if images.count == 1 {
            SingleImageView(image: images[0])
        } else {
            ImageGridView(images: images)
        }
    }
}

struct SingleImageView: View {
    let image: AppBskyLexicon.Embed.ImagesDefinition.ViewImage
    
    // Calculate height based on aspect ratio, with fallback to maxHeight
    private var calculatedHeight: CGFloat {
        guard let aspectRatio = image.aspectRatio else {
            return PostImagesView.Constants.maxHeight
        }
        
        let ratio = CGFloat(aspectRatio.height) / CGFloat(aspectRatio.width)
        let calculatedHeight = PostImagesView.Constants.maxWidth * ratio
        
        // Ensure we don't exceed maxHeight
        return min(calculatedHeight, PostImagesView.Constants.maxHeight)
    }
    
    var body: some View {
        AsyncImage(url: image.thumbnailImageURL) { phase in
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
                    .frame(maxHeight: PostImagesView.Constants.maxHeight)
                    .cornerRadius(12)
            case .failure:
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: calculatedHeight)
                    .cornerRadius(12)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct ImageGridView: View {
    let images: [AppBskyLexicon.Embed.ImagesDefinition.ViewImage]
    
    // Calculate height for grid items based on aspect ratio, with fallback
    private func calculatedHeight(for image: AppBskyLexicon.Embed.ImagesDefinition.ViewImage) -> CGFloat {
        guard let aspectRatio = image.aspectRatio else {
            return PostImagesView.Constants.maxHeight / 2
        }
        
        let ratio = CGFloat(aspectRatio.height) / CGFloat(aspectRatio.width)
        let calculatedHeight = (PostImagesView.Constants.maxWidth / 2) * ratio
        
        // Ensure we don't exceed maxHeight/2 for grid layout
        return min(calculatedHeight, PostImagesView.Constants.maxHeight / 2)
    }
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 4),
            GridItem(.flexible(), spacing: 4)
        ], spacing: 4) {
            ForEach(images.prefix(4), id: \.thumbnailImageURL) { image in
                AsyncImage(url: image.thumbnailImageURL) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: calculatedHeight(for: image))
                            .cornerRadius(12)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: PostImagesView.Constants.maxHeight / 2)
                            .clipped()
                            .cornerRadius(12)
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: calculatedHeight(for: image))
                            .cornerRadius(12)
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
    }
} 
