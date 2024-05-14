//
//  GeneratorViewModel.swift
//  IA_ImageGenerator
//
//  Created by Marcelo Amaral Alves on 2024-05-14.
//

import Foundation

extension GeneratorView {
    class ViewModel: ObservableObject {
        @Published var duration = 0
        @Published var image: URL?
        
        var prompt: String = ""
        let selectedStyle: ImageStyle
        
        private let openAIService = OpenAIService()
        
        init(prompt: String, selectedStyle: ImageStyle) {
            self.prompt = prompt
            self.selectedStyle = selectedStyle
        }
        
        func generateImage() {
            let formattedPrompt = "\(selectedStyle.title) image of \(prompt)"
            
            Task {
                do {
                    let generatedImage = try await openAIService.generateImage(promt: formattedPrompt)
                    guard let imageURLString = generatedImage.data.first?.url, let imageUrl =
                            URL(string: imageURLString) else {
                        print("Failed to generate image")
                        return
                    }
                    
                    await MainActor.run {
                        self.image = imageUrl
                    }
                } catch {
                    print(error)
                }
            }
        }
    }

}
