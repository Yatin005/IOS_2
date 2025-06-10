//
//  Patient.swift
//  Lab_5_Yatin
//
//  Created by Yatin Parulkar on 2025-06-10.
//

import Foundation

class Patient : ObservableObject{
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var allergies: String = ""
    @Published var medicalHistory: String = ""
    
    init(email: String, password: String, allergies: String, medicalHistory: String){
        self.email = email
        self.name = name
        self.allergies = allergies
        self.medicalHistory = medicalHistory
    }
    init() {
        self.email = ""
        self.name = ""
        self.allergies = ""
        self.medicalHistory = ""
    }
}

