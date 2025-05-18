import SwiftUI
import ATProtoKit

struct PostQuotedPostView: View {
    let view: AppBskyLexicon.Embed.RecordDefinition.View
    var body: some View {
        if let viewModel = view.toFeedViewPostViewModel() {
            FeedViewPost(viewModel: viewModel)
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                )
        } else {
            Text("Quoted post unavailable")
                .foregroundColor(.secondary)
                .padding()
        }
    }
} 
