//
//  User.swift
//  week5_class
//
//  Created by Arch Umeshbhai Patel on 2025-06-06.
//

import Foundation

class User : ObservableObject {
    @Published var email : String
    @Published var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    init() {
        self.email = "admin@admin.com"
        self.password = "password"
    }
}
