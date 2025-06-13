//
//  LibraryPicker.swift
//  week5_class
//
//  Created by Yatin Parulkar on 2025-06-13.
//

import Foundation
import PhotosUI
import SwiftUI

struct LibraryPicker : UIViewControllerRepresentable {
  
    @Binding var selectedImage : UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<LibraryPicker>) -> some UIViewController {
        
        //configure the View Controller
        var libraryConfig = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        libraryConfig.selectionLimit = 1
        libraryConfig.filter = .images
        
        //create a photo library picker
        let imagePicker = PHPickerViewController(configuration: libraryConfig)
        imagePicker.delegate = context.coordinator
        return imagePicker
        
    }//makeUIViewController

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //update UI if required
        
    }//updateUIViewController

    func makeCoordinator() -> LibraryPicker.Coordinator {
        return Coordinator(parent: self)
    }//makeCoordinator

    class Coordinator : NSObject, PHPickerViewControllerDelegate{
        
        var parent : LibraryPicker
        
        init(parent: LibraryPicker) {
            self.parent = parent
        }
        
        //callback after the user selects the picture from PhotoLibrary
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            //close the PhotoLibrary
            picker.dismiss(animated: true)
            
            //check if user selected any picture
            if (results.count > 0){
                print(#function, "user selected picture. perform necessary operation using picture")
                
                if let selectedImage = results.first{
                    //check if the selected image can be converted into UIImage type
                    if selectedImage.itemProvider.canLoadObject(ofClass: UIImage.self){
                        selectedImage.itemProvider.loadObject(ofClass: UIImage.self){ image, error in
                            
                            guard error == nil else{
                                print(#function, "Cannot convert selected asset to UIImage")
                                return
                            }
                            
                            //convert the selected asset into UIImage
                            if let img = image {
                                self.parent.selectedImage = img as? UIImage
                            }
                        }
                    }
                }
                
            }else{
                print(#function, "User did not select any pictures")
                return
            }
            
        }
        
    }//Coordinator

    }
