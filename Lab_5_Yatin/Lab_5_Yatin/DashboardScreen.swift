//
//  DashboardScreen.swift
//  Lab_5_Yatin
//
//  Created by Deep Kaleka on 2025-06-10.
//

import SwiftUI

struct DashboardScreen: View {
    @EnvironmentObject var patient: Patient
        @Binding var authFlow: AuthFlow

        var body: some View {
            NavigationView {
                VStack(spacing: 20) {
                    Text("Welcome, \(patient.name)!")
                        .font(.title)
                    Text("Email: \(patient.email)")
                    Text("Allergies: \(patient.allergies)")
                    Text("Medical History: \(patient.medicalHistory)")
                    Spacer()
                }
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink("Profile", destination: ProfileScreen())
                        NavigationLink("Records", destination: RecordsScreen())
                        Button("Logout") {
                            authFlow = .signIn
                        }
                    }
                }
                .navigationTitle("Dashboard")
            }
        }
    }

#Preview {
    DashboardScreen(authFlow: .constant(.home))
        .environmentObject(Patient(email: "yatin@gmail.com", password: "123456", allergies: "Penicillin", medicalHistory: "None"))
}
