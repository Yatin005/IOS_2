//
//  PriceCalculationScreen.swift
//  Lab_4-Yatin
//
//  Created by Yatin Parulkar on 2025-06-05.
//

import SwiftUI

struct PriceCalculationScreen: View {
    
    var quantity: Int
    var price = 5.0
    
    var totalPrice: Double {
        Double(quantity) * price
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Quantity: \(quantity)")
            Text("Total Price: $\(totalPrice, specifier: "%.2f")")
            
            NavigationLink(
                destination: FinalBillScreen(price: totalPrice),
                label: {
                    Text("Calculate Final Bill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.black)
                        
                }
            )
            
            Spacer()
        }
        .padding()
        .navigationTitle("Price Calculation Screen")
    }
}

