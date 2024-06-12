import SwiftUI

struct ChatHistoryView: View {
    @Binding var messages: [Message]
    
    var body: some View {
        List {
            ForEach(messages) { message in
                HStack {
                    if message.isUser {
                        Spacer()
                        Text(message.text)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    } else {
                        Text(message.text)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Chat History")
    }
}

struct ChatHistoryView_Previews: PreviewProvider {
    @State static var messages: [Message] = [Message(text: "Hello", isUser: true), Message(text: "Hi", isUser: false)]
    static var previews: some View {
        ChatHistoryView(messages: $messages)
    }
}
