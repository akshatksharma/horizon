import SwiftUI

struct PostTimestampView: View {
    let timestamp: String
    
    var body: some View {
        Text(timestamp)
            .font(.callout)
            .foregroundStyle(.secondary)
            .lineLimit(1)
    }
} 