//
//  AccountScreen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//

import SwiftUI

struct AccountScreen: View {
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
    AccountScreen()
        .environmentObject(User(email: "sample@apple.com", password: "sample123"))
}
