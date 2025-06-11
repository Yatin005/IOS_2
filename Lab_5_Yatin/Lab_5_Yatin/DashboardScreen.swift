//
//  DashboardScreen.swift
//  Lab_5_Yatin
//
//  Created by Yatin Parulkar on 2025-06-10.
//

import SwiftUI

struct DashboardScreen: View {
    
    @Binding var authFlow: AuthFlow
    @State private var showProfile : Bool = false
    @State private var showRecords : Bool = false
    
    @EnvironmentObject var patient: Patient
    
    var body: some View {
        NavigationStack {
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
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Button("Profile"){
                            showProfile = true
                        }
                        Button("Records"){
                            showRecords = true
                        }
                        Button("Logout"){
                            authFlow = .signIn
                        }
                        
                    } label: {
                        Label("Menu", systemImage: "ellipsis.circle")
                        
                    }
                }
            }
            .navigationDestination(isPresented: $showProfile){
                ProfileScreen().environmentObject(patient)
            }
            .navigationDestination(isPresented: $showRecords){
                RecordsScreen().environmentObject(patient)
                    
            }.navigationTitle(Text("Dashboard"))
        }
    }
}
#Preview {
    DashboardScreen(authFlow: .constant(.home))
        .environmentObject(Patient(email: "yatin@gmail.com", name: "yatin", allergies: "Penicillin", medicalHistory: "None"))
}
