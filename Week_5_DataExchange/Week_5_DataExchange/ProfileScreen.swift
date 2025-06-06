//
//  ProfileScreen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//

import SwiftUI

struct ProfileScreen: View {
    @State private var email : String = "admin@example.com"
    @State private var password : String = "admin123"
    
    @EnvironmentObject var user : User
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Form{
                TextField("Enter email", text: $email)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Enter password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                
                Button("Update"){
                    //verify the credential
                    if (!email.isEmpty && !password.isEmpty){
                        //update details
                        
                        user.email = email
                        user.password = password
                        
                        //show alert that the details have been updated
                        
                        dismiss()
                    }
                }.buttonStyle(.borderedProminent)
                
                
            }//Form
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            //show existing data
            email = user.email
            password = user.password
        }
    }
}

#Preview {
    ProfileScreen()
        .environmentObject(User(email: "sample@apple.com", password: "sample123"))
}
