import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var vm = ImageViewModel()

    @State private var showingPicker = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var imageName = ""
    @State private var editingImage: FirebaseImage? = nil

    @State private var alertMessage = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(vm.images) { img in
                        HStack {
                            AsyncImage(url: URL(string: img.url)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 80, height: 80)
                                }
                            }
                            Text(img.name)
                                .font(.headline)
                            Spacer()
                            Button("Edit") {
                                editingImage = img
                                imageName = img.name
                                showingPicker = true
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            Button("Delete") {
                                vm.deleteImage(img) { result in
                                    handleResult(result, successMessage: "Image deleted successfully!")
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .foregroundColor(.red)
                        }
                    }
                }

                HStack {
                    TextField("Image name", text: $imageName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Select Image") {
                        showingPicker = true
                        editingImage = nil
                    }
                }
                .padding()

                if let data = selectedImageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }

                Button(editingImage == nil ? "Upload Image" : "Update Image") {
                    guard let data = selectedImageData, !imageName.isEmpty else { return }
                    if let editingImage = editingImage {
                        vm.updateImage(editingImage, newImageData: data) { result in
                            handleResult(result, successMessage: "Image updated successfully!")
                        }
                    } else {
                        vm.uploadImage(data, name: imageName) { result in
                            handleResult(result, successMessage: "Image uploaded successfully!")
                        }
                    }
                    selectedImageData = nil
                    imageName = ""
                    editingImage = nil
                }
                .disabled(selectedImageData == nil || imageName.isEmpty)
                .padding()
            }
            .navigationTitle("Image Gallery")
            .onAppear {
                vm.fetchImages()
            }
            .photosPicker(isPresented: $showingPicker, selection: $selectedItem, matching: .images)
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let item = newItem {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    func handleResult(_ result: Result<Void, Error>, successMessage: String) {
        switch result {
        case .success:
            alertMessage = successMessage
        case .failure(let error):
            alertMessage = "Error: \(error.localizedDescription)"
        }
        showAlert = true
    }
}
