import SwiftUI

struct GeneratedImage: Identifiable, Codable {
    let id = UUID()
    let url: URL
}

struct GeneratedImagesView: View {
    @Binding var images: [GeneratedImage]
    
    var body: some View {
        List {
            ForEach(images) { image in
                AsyncImage(url: image.url) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
            }
        }
        .navigationTitle("Generated Images")
    }
}

struct GeneratedImagesView_Previews: PreviewProvider {
    @State static var images: [GeneratedImage] = [GeneratedImage(url: URL(string: "https://example.com/image.jpg")!)]
    static var previews: some View {
        GeneratedImagesView(images: $images)
    }
}
