import SwiftUI
import ATProtoKit
import UIKit

struct PostExternalAttachmentView: View {
    let external: AppBskyLexicon.Embed.ExternalDefinition.View
    
    @State private var showingSafari = false
    
    private struct Constants {
        static let thumbnailHeight: CGFloat = 120
        static let cornerRadius: CGFloat = 12
        static let cardPadding: CGFloat = 12
        static let contentSpacing: CGFloat = 8
        static let textSpacing: CGFloat = 4
    }
    
    private var domainFromURL: String {
        if let url = URL(string: external.external.uri) {
            return url.host ?? external.external.uri
        }
        return external.external.uri
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            // Thumbnail image with fixed height
            thumbnailView
                .frame(height: Constants.thumbnailHeight)
                .frame(maxWidth: .infinity)
                .clipped()
            
            // Content section with explicit layout
            contentView
                .padding(.bottom, Constants.cardPadding)
                .padding(.horizontal, Constants.cardPadding)
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(Constants.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
        )
        .fixedSize(horizontal: false, vertical: true)
        .onTapGesture {
            openURL()
        }
        .sheet(isPresented: $showingSafari) {
            if let url = URL(string: external.external.uri) {
                SafariView(url: url)
            }
        }
    }
    
    private func openURL() {
        guard let url = URL(string: external.external.uri), 
              UIApplication.shared.canOpenURL(url) else {
            showingSafari = true
            return
        }

        UIApplication.shared.open(url, options: [.universalLinksOnly: true]) { success in
            guard !success else { return }
            showingSafari = true
        }
    }
    
    @ViewBuilder
    private var thumbnailView: some View {
        if let thumbnailURL = external.external.thumbnailImageURL {
            AsyncImage(url: thumbnailURL) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        )
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: Constants.thumbnailHeight)
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "link")
                                .foregroundColor(.gray)
                                .font(.title2)
                        )
                @unknown default:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
            }
        } else {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .overlay(
                    Image(systemName: "link")
                        .foregroundColor(.gray)
                        .font(.title2)
                )
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack(alignment: .leading, spacing: Constants.textSpacing) {
            // Title
            Text(external.external.title)
                .font(.system(size: 15, weight: .medium))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            // Description
            if !external.external.description.isEmpty {
                Text(external.external.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Domain
            Text(domainFromURL)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
} 
