import Foundation

struct OpenAIChatResponse: Decodable {
    let choices: [ChatChoice]
}

struct ChatChoice: Decodable {
    let message: ChatMessage
}

struct ChatMessage: Decodable {
    let role: String
    let content: String
}

class OpenAIChatService {
    static let shared = OpenAIChatService()

    private init() {}

    func sendMessage(_ message: String, completion: @escaping (String) -> Void) {
        let endpoint = "https://api.openai.com/v1/chat/completions"
        guard let url = URL(string: endpoint) else {
            completion("URL inválida.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(Constants.openAIAPIKey)", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "user", "content": message]
            ],
            "max_tokens": 150,
            "temperature": 0.7
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion("Erro ao criar o corpo da requisição.")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("Erro: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                completion("Dados inválidos.")
                return
            }

            do {
                let openAIResponse = try JSONDecoder().decode(OpenAIChatResponse.self, from: data)
                let responseText = openAIResponse.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Sem resposta."
                completion(responseText)
            } catch {
                completion("Erro ao processar a resposta.")
            }
        }

        task.resume()
    }
}
