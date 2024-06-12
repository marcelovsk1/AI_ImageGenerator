import SwiftUI

struct GeneratorView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            // Adicionando a imagem de fundo
            Image("clouds") // Substitua "clouds" pelo nome da sua imagem
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
            
            Color.white.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Spacer()
                
                Text("Generated Image")
                    .font(.custom("Inter-Bold", size: 34))
                    .bold()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack {
                    AsyncImage(url: viewModel.image) { image in
                        image.resizable().aspectRatio(1, contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .background(Color.gray.opacity(0.2))
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
                    .clipped()
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black.opacity(0.5))
        }
        .onAppear {
            viewModel.generateImage()
        }
    }
}

struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView(viewModel: .init(prompt: "red car", selectedStyle: .threeDRender))
    }
}
