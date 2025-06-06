//
//  SignInScreen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//

import SwiftUI

struct SignInScreen: View {
    @State private var email :String = "admin@example.com"
    @State private var password :String = "123456"
    
    @Binding var authFlow: AuthFlow
    var body: some View {
    
    VStack {
        NavigationStack {
            Form {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button ("Login"){
                //verify credentials
                    if(!email.isEmpty && !password.isEmpty){
                        //go to homeScreen
                        authFlow = .home
                    }
                }.buttonStyle(.borderedProminent)
                
                Button("Create Account"){
                    authFlow = .signUp
                }
            } //Form
        }
    }
    .padding()
}
}

#Preview {
    SignInScreen(authFlow: .constant(.signIn))
}
