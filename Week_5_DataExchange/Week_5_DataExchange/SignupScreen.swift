//
//  SignupScreen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//

import SwiftUI

struct SignupScreen: View {
    @State private var email :String = "admin@example.com"
    @State private var password :String = "123456"
    
    @Binding var authFlow: AuthFlow
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                    
                    Button("Create Account"){
                        authFlow = .home
                    }.buttonStyle(.borderedProminent)
                } //Form
            }
        }
        .padding()
    }
}


#Preview {
    SignupScreen(authFlow: .constant(.signUp))
}
