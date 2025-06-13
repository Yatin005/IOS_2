//
//  ProfileScreen.swift
//  week5_class
//
//  Created by Arch Umeshbhai Patel on 2025-06-06.
//

import SwiftUI
import PhotosUI

struct ProfileScreen: View {
    /*
     
     //Add the following permission under the info tab in proj file
     
     key : privacy - camera usage description
     value: Week_5 apps need to access camera
     
     same for
     */
    
    @EnvironmentObject var user : User
    @State private var email : String = ""
    @State private var password : String = ""
    @Environment(\.dismiss) var dimiss
    
    @State private var profileImage: UIImage?
    @State private var showSheet : Bool = false
    @State private var permissionGranted: Bool = false
    @State private var showPicker : Bool = false
    @State private var isUsingCamera : Bool = false
    
    
    var body: some View {
        VStack{
            Form{
                Button(action: {
                    if(self.permissionGranted){
                        self.showSheet  = true
                    } else{
                        self.requestCameraPermission()
                    }
                }){
                    Image(uiImage: profileImage ?? UIImage(systemName: "person")!)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }//Button
                .actionSheet(isPresented: self.$showSheet){
                    ActionSheet(title: Text("Choose Picture"),
                                message: Text("Select profile picture to upload"),
                                buttons: [
                                    .default(Text("Choose from photo library")){
                                        //check if photolibrary source i s availabe
                                        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                                            print(#function, "PhotoLibrary isnt available on the device")
                                            return
                                        }
                                        self.isUsingCamera = false
                                        self.showPicker = true
                                    },
                                    .default(Text("click a new pic from camera")){
                                        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                                            print(#function, "Camera isnt available on the device")
                                            return
                                        }
                                        self.isUsingCamera = false
                                        self.showPicker = true
                                        
                                    },
                                    //check if the cameras source is availabe
                                    .cancel()
                                ]
                    )//Actionsheet
                }//actionsheet
                
                Text("\(user.email)")
                
                SecureField("Enter password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                
                Button("Update"){
                    //verify the credential
                    if (!email.isEmpty && !password.isEmpty){
                        user.email = user.email
                        user.password = password
                        dimiss()
                    }
                }.buttonStyle(.borderedProminent)
                
                
            }//Form
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        } .onAppear(){
            password = user.password
            self.checkCameraPermission()
        }
        .fullScreenCover(isPresented: $showPicker){
            if(isUsingCamera){
                CameraPicker(selectedImage: $profileImage)
                //open the camera picker
            } else {
                //open library picker
                LibraryPicker(selectedImage: $profileImage
                )
            }
        }
    }//body
    private func checkCameraPermission(){
        
        switch PHPhotoLibrary.authorizationStatus(){
        case.authorized:
            self.permissionGranted = true
        case .notDetermined, .denied:
            self.permissionGranted = false
            self.requestCameraPermission()
        case .restricted, .limited:
            //inform user or request full access based on requirements
            
            return
        @unknown default:
            return
        }
        
    }
    private func requestCameraPermission(){
        PHPhotoLibrary.requestAuthorization(){ status in
            switch status{
            case.authorized:
                self.permissionGranted = true
            case .notDetermined, .denied:
                self.permissionGranted = false
                self.requestCameraPermission()
            case .restricted, .limited:
                //inform user or request full access based on requirements
                
                return
            @unknown default:
                return
            }//switch
        }//reqAuthorization
    }//reqCamPermission
}
//struct
#Preview {
    ProfileScreen().environmentObject(User())
}

