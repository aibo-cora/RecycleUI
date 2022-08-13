//
//  ContentView.swift
//  ImagePicker
//
//  Created by Yura on 7/12/22.
//

import SwiftUI

struct ImagePickerView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200, alignment: .center)
                    .overlay {
                        Circle().stroke(.gray, lineWidth: 1)
                    }
                    .shadow(color: .black, radius: 5)
            }
            Spacer()
            Button {
                showingImagePicker.toggle()
            } label: {
                Text("Select Image")
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { newValue in
                guard let image = inputImage else {
                    return
                }

                self.image = Image(uiImage: image)
            }
        }
        .padding()
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}
