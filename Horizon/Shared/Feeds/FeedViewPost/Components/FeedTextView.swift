import SwiftUI

struct FeedTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 15))
            .lineSpacing(2)
    }
} 
