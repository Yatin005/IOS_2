//
//  ProfileScreen.swift
//  week5_class
//
//  Created by Arch Umeshbhai Patel on 2025-06-06.
//

import SwiftUI

struct ProfileScreen: View {
    
    @EnvironmentObject var user : User
    @State private var email : String = ""
    @State private var password : String = ""
    @Environment(\.dismiss) var dimiss
    var body: some View {
        VStack{
            Form{
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
        }
    }
}

#Preview {
    ProfileScreen().environmentObject(User())
}

