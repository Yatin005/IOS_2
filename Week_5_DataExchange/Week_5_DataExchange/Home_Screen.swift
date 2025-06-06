//
//  Home_Screen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//


import SwiftUI


struct Home_Screen: View {
    
    @Binding var authFlow: AuthFlow
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
                            
                        }
                        
                        Button("Account"){
                            
                        }
                        
                        Button("Logout"){
                            authFlow = .signIn
                        }
                        
                    }label: {
                        
                        Image(systemName: "gear")
                        
                    }
                    
                }
                
            }
            
        }//NavigationStack
        
    }
    
}


#Preview {
    Home_Screen(authFlow: .constant(.signIn))
}
