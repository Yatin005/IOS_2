//
//  AccountScreen.swift
//  week5_class
//
//  Created by Arch Umeshbhai Patel on 2025-06-06.
//

import SwiftUI

struct AccountScreen: View {
    @State private var email : String = "admin@example.com"
    @State private var password : String = "password"
    @EnvironmentObject var user : User
    var body: some View {
        VStack{
            Text("Account Information")
                .font(.title)
                    
            Text("Email : \(user.email)")
                    
            Spacer()
        }
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AccountScreen().environmentObject(User())
}
