//
//  GeneratorView.swift
//  IA_ImageGenerator
//
//  Created by Marcelo Amaral Alves on 2024-05-14.
//

import SwiftUI

struct GeneratorView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
            
            Text("Generated Image")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack {
//                Text("Time spent: \("")")
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
        .background(Color(red: 0.0, green: 0.7, blue: 0.9))
        .onAppear{
            viewModel.generateImage()
        }
    }
}
#Preview {
    GeneratorView(viewModel: .init(prompt: "red car", selectedStyle: .threeDRender))
}
