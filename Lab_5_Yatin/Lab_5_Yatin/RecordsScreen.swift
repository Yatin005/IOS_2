//
//  RecordsScreen.swift
//  Lab_5_Yatin
//
//  Created by Deep Kaleka on 2025-06-10.
//

import SwiftUI

struct RecordsScreen: View {
    @EnvironmentObject var patient: Patient

       var body: some View {
           Form {
               TextField("Allergies", text: $patient.allergies)
               TextField("Medical History", text: $patient.medicalHistory)
           }
           .navigationTitle("Edit Records")
       }
   }

#Preview {
    RecordsScreen()
}
