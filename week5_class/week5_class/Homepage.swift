//
//  Homepage.swift
//  week5_class
//
//  Created by Arch Umeshbhai Patel on 2025-06-06.
//

import SwiftUI

struct HomeScreen: View {
    @Binding var authFlow: AuthFlow
    @EnvironmentObject var user : User
    @State private var showProfile : Bool = false
    @State private var showAccount : Bool = false
    
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
            .navigationDestination(isPresented: $showAccount) {
                AccountScreen().environmentObject(user)
            }
            .navigationDestination(isPresented: $showProfile) {
                ProfileScreen().environmentObject(user)
            }
        }//NavigationStack
    }
}
#Preview {
    HomeScreen(authFlow: .constant(.signUp)).environmentObject(User())
}
