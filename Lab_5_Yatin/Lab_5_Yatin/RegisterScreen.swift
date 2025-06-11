//
//  RegisterScreen.swift
//  Lab_5_Yatin
//
//  Created by Yatin Parulkar  on 2025-06-10.
//

import SwiftUI

struct RegisterScreen: View {
    @EnvironmentObject var patient: Patient
       @Binding var authFlow: AuthFlow

       @State private var name = ""
       @State private var email = ""
       @State private var allergies = ""
       @State private var medicalHistory = ""

       var body: some View {
           Form {
               TextField("Name", text: $name)
               TextField("Email", text: $email)
               TextField("Allergies", text: $allergies)
               TextField("Medical History", text: $medicalHistory)

               Button("Register") {
                   patient.name = name
                   patient.email = email
                   patient.allergies = allergies
                   patient.medicalHistory = medicalHistory
                   authFlow = .home
               }
           }
           .navigationTitle("Register Patient")
       }
   }

#Preview {
    RegisterScreen(authFlow: .constant(.signUp))
        .environmentObject(Patient(email: "yatin@gmail.com", name: "yatin", allergies: "Penicillin", medicalHistory: "None"))
}
