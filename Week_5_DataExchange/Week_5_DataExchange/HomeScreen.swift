//
//  HomeScreen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//


import SwiftUI


struct HomeScreen: View {
    
    @Binding var authFlow: AuthFlow
    @State private var showProfile: Bool = false
    @State private var showAccount: Bool = false
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("Welcome, ")
                Spacer()
                
            }//VStack
            
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Button("Profile"){
                            showProfile = true
                        }
                        
                        Button("Account"){
                            showAccount = true
                        }
                        
                        Button("Logout"){
                            authFlow = .signIn
                        }
                        
                    }label: {
                        
                        Image(systemName: "gear")
                        
                    }
                    
                }
                
            }
            .navigationDestination(isPresented: $showProfile) {
                ProfileScreen()
            }
            .navigationDestination(isPresented: $showAccount) {
                AccountScreen()
            }
        }//NavigationStack
        
    }
    
}
