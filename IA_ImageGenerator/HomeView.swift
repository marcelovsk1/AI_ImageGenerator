import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("vangogh1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                
                // Overlay escuro para melhorar a legibilidade
                Color.white.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    Text("Bem-vindo ao AI Image Generator")
                        .font(.custom("Inter-Bold", size: 34))
                        .foregroundColor(.black)
                        .padding(.bottom, 50) // Ajusta o espaço abaixo do texto
                        .shadow(radius: 10)
                    
                    VStack(spacing: 30) {
                        NavigationLink(destination: ChatView()) {
                            HStack {
                                Image(systemName: "message.fill")
                                    .foregroundColor(.white)
                                Text("Chat")
                                    .font(.custom("Inter-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(15)
                            .padding(.horizontal, 40)
                            .shadow(radius: 10)
                        }
                        
                        NavigationLink(destination: PromptView()) {
                            HStack {
                                Image(systemName: "photo.fill")
                                    .foregroundColor(.white)
                                Text("Image Generator")
                                    .font(.custom("Inter-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(15)
                            .padding(.horizontal, 40)
                            .shadow(radius: 10)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
