import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct ChatView: View {
    @State private var messages: [Message] = []
    @State private var inputText: String = ""
    @State private var errorMessage: String? = nil
    
    var body: some View {
        ZStack {
            // Adicionando a imagem de fundo
            Image("vangogh")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
            
            // Overlay escuro para melhorar a legibilidade
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(messages) { message in
                            HStack {
                                if message.isUser {
                                    Spacer()
                                    Text(message.text)
                                        .padding()
                                        .background(Color.black.opacity(0.9))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 20)
                                } else {
                                    Text(message.text)
                                        .padding()
                                        .background(Color.black.opacity(0.6))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 20)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.top, 60)
                }
//                .background(Color(UIColor.systemGroupedBackground).opacity(0.8))
//                .cornerRadius(10)
//                .padding()
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                HStack {
                    TextField("Digite sua mensagem", text: $inputText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .shadow(radius: 2)
                        .padding(.leading, 10)
                    
                    Button(action: sendMessage) {
                        Text("Enviar")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, 10)
                }
                .padding(.bottom, 50)
            }
        }
        .navigationTitle("Chat")
        .background(Color(UIColor.systemBackground).opacity(0.8))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func sendMessage() {
        let userMessage = Message(text: inputText, isUser: true)
        messages.append(userMessage)
        inputText = ""
        
        OpenAIChatService.shared.sendMessage(userMessage.text) { response in
            DispatchQueue.main.async {
                if response.contains("Erro") {
                    self.errorMessage = response
                } else {
                    self.errorMessage = nil
                    let responseMessage = Message(text: response, isUser: false)
                    messages.append(responseMessage)
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
