//
//  ProfileScreen.swift
//  Lab_5_Yatin
//
//  Created by Deep Kaleka on 2025-06-10.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var patient: Patient

       var body: some View {
           Form {
               TextField("Name", text: $patient.name)
               TextField("Email", text: $patient.email)
           }
           .navigationTitle("Edit Profile")
       }
   }

#Preview {
    ProfileScreen()
}
