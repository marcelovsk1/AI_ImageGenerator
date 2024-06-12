import SwiftUI

struct PromptView: View {
    @State private var selectedStyle = ImageStyle.allCases[0]
    @State var promptText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Adicionando a imagem de fundo
                Image("clouds")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                
                // Overlay escuro para melhorar a legibilidade
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    Text("Image_Generator")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Choose a Style")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    
                    GeometryReader { reader in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(ImageStyle.allCases, id: \.self) { imageStyle in
                                    Button(action: {
                                        selectedStyle = imageStyle
                                    }) {
                                        Image(imageStyle.rawValue)
                                            .resizable()
                                            .background(Color.yellow)
                                            .scaledToFill()
                                            .frame(width: reader.size.width * 0.4, height: reader.size.width * 0.4 * 1.4)
                                            .clipped()
                                            .shadow(radius: 10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 1)
                                                    .stroke(Color.yellow, lineWidth: imageStyle == selectedStyle ? 4 : 0)
                                            )
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: 250)
                    
                    Spacer(minLength: 0)
                    
                    Text("Enter a prompt")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    
                    TextEditor(text: $promptText)
                        .scrollContentBackground(.hidden)
                        .padding()
                        .background(Color(red: 0.0, green: 0.7, blue: 0.9))
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .tint(Color.yellow)
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        NavigationLink {
                            GeneratorView(viewModel: .init(prompt: promptText, selectedStyle: selectedStyle))
                        } label: {
                            Text("Generate")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(red: 0.0, green: 0.7, blue: 0.9))
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(10)
//                .background(Color.black.opacity(0.5))
//                .cornerRadius(20)
                .padding(10)
            }
        }
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView()
    }
}