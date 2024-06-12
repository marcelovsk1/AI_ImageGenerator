import SwiftUI

struct PromptView: View {
    @State private var selectedStyle = ImageStyle.allCases[0]
    @State var promptText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Adicionando a imagem de fundo
                Image("clouds") // Substitua "clouds" pelo nome da sua imagem
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                
                Color.white.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    Text("Image_Generator")
                        .font(.custom("Inter-Bold", size: 34))
                        .foregroundColor(.black)
                        .padding(.top, 40)
                        .shadow(radius: 10)
                    
                    Text("Choose a Style")
                        .font(.custom("Inter-Bold", size: 24))
                        .foregroundColor(.black)
                        .shadow(radius: 10)
                    
                    GeometryReader { reader in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(ImageStyle.allCases, id: \.self) { imageStyle in
                                    Button(action: {
                                        selectedStyle = imageStyle
                                    }) {
                                        Image(imageStyle.rawValue)
                                            .resizable()
                                            .background(Color.blue)
                                            .scaledToFill()
                                            .frame(width: reader.size.width * 0.4, height: reader.size.width * 0.4 * 1.4)
                                            .clipped()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 1)
                                                    .stroke(Color.blue, lineWidth: imageStyle == selectedStyle ? 4 : 0)
                                            )
                                            .shadow(radius: 10)
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: 250)
                    
                    Spacer(minLength: 0)
                    
                    Text("Enter a prompt")
                        .font(.custom("Inter-Bold", size: 20))
                        .bold()
                        .foregroundColor(.black)
                    
                    TextEditor(text: $promptText)
                        .scrollContentBackground(.hidden)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .tint(Color.blue)
                        .frame(height: 300)
                        .shadow(radius: 10)
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        NavigationLink {
                            GeneratorView(viewModel: .init(prompt: promptText, selectedStyle: selectedStyle))
                        } label: {
                            Text("Generate")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                                .padding(.bottom, 30)
                                .shadow(radius: 10)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
            }
        }
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView()
    }
}
