//
//  SignupScreen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//

import SwiftUI

struct SignUpScreen: View {
    @State private var email : String = "admin@example.com"
    @State private var password : String = "admin123"
    
    @Binding var authFlow: AuthFlow
    
    @EnvironmentObject var user : User
    
    var body: some View {
            Form{
                TextField("Enter email", text: $email)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Enter password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                Button("Create Account"){
                    //create account
                    //update shared user object
                    user.email = email
                    user.password = password
                    
                    //go to home screen
                    authFlow = .home
                }
                
            }//Form
            .onAppear(){
                //show existing data
                email = user.email
                password = user.password
            }
    }
}

#Preview {
    SignUpScreen(authFlow: .constant(.signUp))
        .environmentObject(User(email: "sample@apple.com", password: "sample123"))
}
