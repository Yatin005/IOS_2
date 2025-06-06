//
//  User.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//


import UIKit

class User : ObservableObject{
    var email : String
    var password : String
    
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
    init() {
        self.email = "NA"
        self.password = "NA"
    }
}
