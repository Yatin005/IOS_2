//
//  ProfileScreen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//

import SwiftUI

struct ProfileScreen: View {
    
    @State private var email :String = "admin@example.com"
    @State private var password :String = "123456"
    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                    Button ("Update"){
                    //verify credentials
                        if(!email.isEmpty && !password.isEmpty){
                            //go to homeScreen
                        }
                    }.buttonStyle(.borderedProminent)
                    
                    
                    
                } //Form
            }
        }
        .navigationTitle("Profile")
        .padding()
    }
    }

#Preview {
    ProfileScreen()
}
