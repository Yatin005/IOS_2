//
//  SignUpScreen.swift
//  week5_class
//
//  Created by Arch Umeshbhai Patel on 2025-06-06.
//

import SwiftUI

struct SignUpScreen: View {
    @State private var email : String = "e@mial.com"
    @State private var password : String = "password"
    @Binding var authFlow: AuthFlow
    @EnvironmentObject var user : User
    var body: some View {
        NavigationStack{
            Form{
                TextField("Enter Email", text: $email)
                SecureField("Enter Password", text: $password)
                Button("Create an Account"){
                    authFlow = .home
                    user.email = email
                    user.password = password
                }
            }
            .navigationTitle("SignIn")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(){
            email = user.email
            password = user.password
            
        }
    }
}

#Preview {
    SignUpScreen(authFlow: .constant(.signUp)).environmentObject(User())
}
