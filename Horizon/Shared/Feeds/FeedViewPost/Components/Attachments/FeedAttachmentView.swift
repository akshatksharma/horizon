import SwiftUI
import ATProtoKit

struct FeedAttachmentView: View {
    let embed: ATUnion.EmbedViewUnion?
    
    var body: some View {
        if let embed = embed {
            switch embed {
            case .embedImagesView(let view):
                PostImagesView(images: view.images)
            case .embedVideoView(let view):
                PostVideoView(video: view)
            case .embedExternalView, .embedRecordView, .embedRecordWithMediaView:
                EmptyView()
            }
        }
    }
}

