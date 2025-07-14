//
//  ImageViewModel.swift
//  lab_9_ImageCRUD
//
//  Created by Deep Kaleka on 2025-07-14.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import PhotosUI

class ImageViewModel: ObservableObject {
    @Published var images: [FirebaseImage] = []
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    init() {
        fetchImages()
    }
    
    func uploadImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }

        let id = UUID().uuidString
        let storageRef = storage.reference().child("images/\(id).jpg")

        // Upload the image to Firebase Storage
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("❌ Upload error: \(error.localizedDescription)")
                return
            }

            // ✅ Only try to get the download URL after upload completes
            storageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("❌ Failed to get download URL: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                // Save metadata to Firestore
                let imageRecord = FirebaseImage(id: id, url: downloadURL.absoluteString)
                do {
                    try self.db.collection("images").document(id).setData(from: imageRecord)
                    DispatchQueue.main.async {
                        self.fetchImages()
                    }
                    print("✅ Image uploaded and Firestore updated.")
                } catch {
                    print("❌ Firestore save error: \(error)")
                }
            }
        }
    }

    func fetchImages() {
        db.collection("images").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.images = documents.compactMap { try? $0.data(as: FirebaseImage.self) }
        }
    }
    
    func deleteImage(image: FirebaseImage) {
        let storageRef = storage.reference(forURL: image.url)
        
        storageRef.delete { error in
            if let error = error {
                print("Delete from storage failed: \(error)")
            }
        }
        
        db.collection("images").document(image.id).delete { error in
            if let error = error {
                print("Delete from Firestore failed: \(error)")
            } else {
                self.images.removeAll { $0.id == image.id }
            }
        }
    }
    
    func updateImage(image: FirebaseImage, newImage: UIImage) {
        deleteImage(image: image)
        uploadImage(image: newImage)
    }
}
