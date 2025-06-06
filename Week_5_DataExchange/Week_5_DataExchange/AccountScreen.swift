//
//  AccountScreen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//

import SwiftUI

struct AccountScreen: View {
    var body: some View {
        VStack{
            Text("Account Information").font(.title)
            
            Text("Email")
            Spacer()
        }
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AccountScreen()
}
