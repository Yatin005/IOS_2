//
//  Home_Screen.swift
//  Week_5_DataExchange
//
//  Created by Deep Kaleka on 2025-06-06.
//


import SwiftUI

struct Home_Screen: View {
    
    @Binding var authFlow: AuthFlow
    @State private var showProfile : Bool = false
    @State private var showAccount : Bool = false
    
    @EnvironmentObject var user : User
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Welcome, \(user.email)")
                
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
            .navigationDestination(isPresented: $showProfile){
                ProfileScreen().environmentObject(user)
            }
            .navigationDestination(isPresented: $showAccount){
                AccountScreen().environmentObject(user)
            }
        }//NavigationStack
    }
}

#Preview {
    Home_Screen(authFlow: .constant(.home))
        .environmentObject(User(email: "sample@apple.com", password: "sample123"))
}

