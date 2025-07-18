import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class ImageViewModel: ObservableObject {
    @Published var images: [FirebaseImage] = []
    private var db = Firestore.firestore()
    private var storage = Storage.storage()

    func fetchImages() {
        db.collection("images").getDocuments { snapshot, error in
            if let error = error {
                print("Fetch error:", error.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else { return }
            let fetchedImages = documents.compactMap { doc -> FirebaseImage? in
                FirebaseImage(dict: doc.data())
            }
            DispatchQueue.main.async {
                self.images = fetchedImages
            }
        }
    }

    func uploadImage(_ imageData: Data, name: String, completion: ((Result<Void, Error>) -> Void)? = nil) {
        let id = UUID().uuidString
        let storageRef = storage.reference().child("images/\(id).jpg")
        print("Uploading to path:", storageRef.fullPath)

        storageRef.putData(imageData) { metadata, error in
            if let error = error {
                print("Upload failed:", error.localizedDescription)
                completion?(.failure(error))
                return
            }
            print("Upload success")
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Download URL error:", error.localizedDescription)
                    completion?(.failure(error))
                    return
                }
                if let url = url {
                    print("Download URL:", url.absoluteString)
                    let newImage = FirebaseImage(id: id, name: name, url: url.absoluteString)
                    self.db.collection("images").document(id).setData(newImage.toDict()) { error in
                        if let error = error {
                            print("Firestore setData error:", error.localizedDescription)
                            completion?(.failure(error))
                            return
                        }
                        DispatchQueue.main.async {
                            self.images.append(newImage)
                        }
                        completion?(.success(()))
                    }
                } else {
                    let err = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL not found"])
                    completion?(.failure(err))
                }
            }
        }
    }

    func deleteImage(_ image: FirebaseImage, completion: ((Result<Void, Error>) -> Void)? = nil) {
        let storageRef = storage.reference(forURL: image.url)
        print("Deleting path:", storageRef.fullPath)

        storageRef.delete { error in
            if let error = error {
                print("Delete failed:", error.localizedDescription)
                completion?(.failure(error))
                return
            }
            self.db.collection("images").document(image.id).delete { error in
                if let error = error {
                    print("Firestore delete error:", error.localizedDescription)
                    completion?(.failure(error))
                    return
                }
                DispatchQueue.main.async {
                    self.images.removeAll { $0.id == image.id }
                }
                completion?(.success(()))
            }
        }
    }

    func updateImage(_ image: FirebaseImage, newImageData: Data, completion: ((Result<Void, Error>) -> Void)? = nil) {
        let storageRef = storage.reference().child("images/\(image.id).jpg")
        print("Updating path:", storageRef.fullPath)

        storageRef.putData(newImageData) { metadata, error in
            if let error = error {
                print("Update upload failed:", error.localizedDescription)
                completion?(.failure(error))
                return
            }
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Update download URL error:", error.localizedDescription)
                    completion?(.failure(error))
                    return
                }
                if let url = url {
                    let updatedImage = FirebaseImage(id: image.id, name: image.name, url: url.absoluteString)
                    self.db.collection("images").document(image.id).setData(updatedImage.toDict()) { error in
                        if let error = error {
                            print("Firestore update error:", error.localizedDescription)
                            completion?(.failure(error))
                            return
                        }
                        DispatchQueue.main.async {
                            if let index = self.images.firstIndex(where: { $0.id == image.id }) {
                                self.images[index] = updatedImage
                            }
                        }
                        completion?(.success(()))
                    }
                } else {
                    let err = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL not found"])
                    completion?(.failure(err))
                }
            }
        }
    }
}
