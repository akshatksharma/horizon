import SwiftUI
import ATProtoKit

struct PostImagesView: View {
    let images: [AppBskyLexicon.Embed.ImagesDefinition.ViewImage]
    let maxHeight: CGFloat = 200
        
    var body: some View {
        if images.count == 1 {
            SingleImageView(image: images[0], maxHeight: maxHeight)
        } else {
            ImageGridView(images: images, maxHeight: maxHeight)
        }
    }
}

struct SingleImageView: View {
    let image: AppBskyLexicon.Embed.ImagesDefinition.ViewImage
    let maxHeight: CGFloat
    
    var body: some View {
        AsyncImage(url: image.thumbnailImageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: maxHeight)
                    .cornerRadius(12)
            case .failure:
                Image(systemName: "photo")
                    .foregroundColor(.gray)
                    .cornerRadius(12)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct ImageGridView: View {
    let images: [AppBskyLexicon.Embed.ImagesDefinition.ViewImage]
    let maxHeight: CGFloat
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 4),
            GridItem(.flexible(), spacing: 4)
        ], spacing: 4) {
            ForEach(images.prefix(4), id: \.thumbnailImageURL) { image in
                AsyncImage(url: image.thumbnailImageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: maxHeight / 2)
                            .clipped()
                            .cornerRadius(12)
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                            .cornerRadius(12)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
    }
} 
