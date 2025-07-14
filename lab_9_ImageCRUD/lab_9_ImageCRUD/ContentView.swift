//
//  ContentView.swift
//  lab_9_ImageCRUD
//
//  Created by Deep Kaleka on 2025-07-14.
//
import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var viewModel = ImageViewModel()
    @State private var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        NavigationView {
            VStack {
                PhotosPicker("Select Image", selection: $selectedItem, matching: .images)
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                selectedImage = uiImage
                            }
                        }
                    }
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    
                    HStack {
                        Button("Upload") {
                            viewModel.uploadImage(image: image)
                            selectedImage = nil
                        }
                        .padding()
                        
                        Button("Clear") {
                            selectedImage = nil
                        }
                    }
                }
                
                List {
                    ForEach(viewModel.images) { image in
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: image.url)) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                         .scaledToFit()
                                         .frame(height: 150)
                                } else {
                                    ProgressView()
                                }
                            }
                            
                            HStack {
                                Button("Delete") {
                                    viewModel.deleteImage(image: image)
                                }
                                .foregroundColor(.red)
                                
                                Button("Replace") {
                                    if let newImage = selectedImage {
                                        viewModel.updateImage(image: image, newImage: newImage)
                                        selectedImage = nil
                                    }
                                }
                                .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Firebase Image CRUD")
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
