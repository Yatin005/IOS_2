//
//  FinalBillScreen.swift
//  Lab_4-Navigation
//
//  Created by Yatin Parulkar on 2025-06-05.
//

import SwiftUI

struct FinalBillScreen: View {
    var price: Double
       let taxRate = 0.13

       var finalAmount: Double {
           price + (price * taxRate)
       }
    var body: some View {
        VStack() {
            Text("Base Price: $\(price, specifier: "%.2f")")
            Text("Tax (13%): $\(price * taxRate, specifier: "%.2f")")
            Text("Final Amount: $\(finalAmount, specifier: "%.2f")")
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Final Bill")
    }
}

