//
//  ProfileScreen.swift
//  Lab_5_Yatin
//
//  Created by Yatin Parulkar on 2025-06-10.
//

import SwiftUI

struct ProfileScreen: View {
    @State private var email : String = "admin@example.com"
    @State private var name : String = "admin"
    
    @EnvironmentObject var patient : Patient
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Form{
                TextField("Enter email", text: $email)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Enter Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                
                Button("Update"){
                    //verify the credential
                    if (!email.isEmpty && !name.isEmpty){
                        //update details
                        
                        patient.email = email
                        patient.name = name
                        
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
            email = patient.email
            name = patient.name
        }
    }
}

#Preview {
    ProfileScreen()
        .environmentObject(Patient(email: "yatin@gmail.com", name: "Yatin", allergies: "None", medicalHistory: "None"))
}
