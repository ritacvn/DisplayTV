import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search Series", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding()
    }
}
