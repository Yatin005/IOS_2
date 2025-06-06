//
//  SignInScreen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//
import SwiftUI

struct SignInScreen: View {
    @State private var email : String = "admin@example.com"
    @State private var password : String = "admin123"
    
    @Binding var authFlow: AuthFlow
    
    @EnvironmentObject var user : User
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Enter email", text: $email)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Enter password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                
                Button("Login"){
                    //verify the credential
                    if (!email.isEmpty && !password.isEmpty){
                        
                        //update shared user object
                        user.email = email
                        user.password = password
                        
                        //go to Home Screen
                        authFlow = .home
                    }
                }.buttonStyle(.borderedProminent)
                
                Button("Create Account"){
                    //go to sign up
                    authFlow = .signUp
                }
                
            }//Form
        }//NavigationStack
        .onAppear(){
            //show existing data
            email = user.email
            password = user.password
        }
    }
}

#Preview {
    SignInScreen(authFlow: .constant(.signIn))
        .environmentObject(User(email: "sample@apple.com", password: "sample123"))
}
