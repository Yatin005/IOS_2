//
//  ContentView.swift
//  Lab_4-Yatin
//
//  Created by Yatin Parulkar on 2025-06-05.
//
import SwiftUI

struct ContentView: View {
    @State private var quantityText = ""
    @State private var alert = false
    @State private var navigate = false
    @State private var quantity = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter product quantity", text: $quantityText)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button("Next") {
                    if let qty = Int(quantityText), qty > 0 {
                        quantity = qty
                        navigate = true
                    } else {
                        alert = true
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(Color.teal)
                .cornerRadius(10)

                
                NavigationLink(
                    destination: PriceCalculationScreen(quantity: quantity),
                    isActive: $navigate
                ) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Yatin Parulkar")
            .alert(isPresented: $alert) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text("Please enter a valid quantity."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
