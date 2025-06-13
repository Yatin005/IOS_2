//
//  SignInScreen.swift
//  week5_class
//
//  Created by Arch Umeshbhai Patel on 2025-06-06.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var email : String = "e@mial.com"
    @State private var password : String = "password"
    
    @Binding var authFlow: AuthFlow
    @EnvironmentObject var user : User
    var body: some View {
        NavigationStack{
            Form{
                TextField("Enter Email", text: $email)
                SecureField("Enter Password", text: $password)
                Button("Login"){
                    if (!email.isEmpty && !password.isEmpty)
                    {
                        authFlow = .home
                        user.email = email
                        user.password = password
                    }
                    
                }.buttonStyle(.borderedProminent)
                Button("Create an Account"){
                    authFlow = .signUp
                }
            }
        }
        .navigationTitle("SignIn")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    SignInScreen(authFlow: .constant(.signIn))
}

