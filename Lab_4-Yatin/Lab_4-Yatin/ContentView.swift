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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter product quantity", text: $quantityText)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                NavigationLink(
                    destination: {
                       if let quantity = Int(quantityText), quantity > 0 {
                            PriceCalculationScreen(quantity: quantity)
                        } else {
                           EmptyView().onAppear {
                                alert.toggle()
                            }
                        }
                     
                    },
                    label: {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.teal)
                            
                    }
                )
                .simultaneousGesture(TapGesture().onEnded {
                                    if Int(quantityText) == nil || Int(quantityText)! <= 0 {
                                        alert = true
                                    }
                                })
                .alert(isPresented: $alert) {
                    Alert(title: Text("Invalid Input"),
                          message: Text("Please enter a valid quantity."),
                          dismissButton: .default(Text("OK")))
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Yatin Parulkar")
        }
    }
}
#Preview {
    ContentView()
}
