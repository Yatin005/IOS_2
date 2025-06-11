//
//  LogInScreen.swift
//  Lab_5_Yatin
//
//  Created by Yatin Parulkar  on 2025-06-10.
//

import SwiftUI

struct LogInScreen: View {
    @EnvironmentObject var patient: Patient
        @Binding var authFlow: AuthFlow

        @State private var name = ""
        @State private var email = ""

    var body: some View {
        Form(){
        VStack() {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            Button("Login") {
                patient.name = name
                patient.email = email
                authFlow = .home
            }.buttonStyle(.borderedProminent)
                .padding(10)
            
            Button("Register") {
                authFlow = .signUp
            }.padding(10)
        }
    }
            .padding()
            .navigationTitle("Yatin Parulkar")
        }
    }
#Preview {
    LogInScreen(authFlow: .constant(.signIn))
}

