//
//  ContentView.swift
//  IA_ImageGenerator
//
//  Created by Marcelo Amaral Alves on 2024-05-13.
//

import SwiftUI

struct PromptView: View {
    @State private var selectedStyle = ImageStyle.allCases[0]
    @State var promptText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Image_Generator")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                
                Text("Choose a Style")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                
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
                                                .stroke(Color.blue,
                                                        lineWidth: imageStyle == selectedStyle ? 4 : 0)
                                        )
                                }
                            }
                        }
                    }
                }
                .frame(height: 250)
                                
                Spacer(minLength: 0)  // Reduzir ou remover o espaço
                                
                
                Text("Enter a prompt")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                
                TextEditor(text: $promptText)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .background(Color(red: 1.0, green: 1.0, blue: 0.0))
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .tint(Color.yellow)
                
                Spacer()
                
                VStack(alignment: .center) {
                    NavigationLink {
                        GeneratorView(viewModel: .init(prompt:
                                                        promptText, selectedStyle: selectedStyle))
                    } label: {
                        Text("Generate")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color(red: 1.0, green: 0.9, blue: 0.0))
            //        .edgesIgnoringSafeArea(.all)
        }
    }
}


struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView()
    }
}


// Project is done!
