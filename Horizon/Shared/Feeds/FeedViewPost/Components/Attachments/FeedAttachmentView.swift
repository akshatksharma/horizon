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
            case .embedRecordView(let view):
                PostQuotedPostView(view: view)
            case .embedExternalView(let view):
                PostExternalAttachmentView(external: view)
            case .embedRecordWithMediaView:
                EmptyView()
            }
        }
    }
}

