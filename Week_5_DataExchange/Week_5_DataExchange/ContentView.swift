//
//  ContentView.swift
//  Week_5_DataExchange
//
//  Created by Yatin Parulkar on 2025-06-06.
//

import SwiftUI

struct ContentView: View {
    @State private var authflow: AuthFlow = .signIn
    
    /*
         
         StateObject - indicated the object of Observable class
         this object will exist as long as the owner view (ContentView) exist
         Current view (ContentView) has the owenership of the object
         
         
         ObservedObject - indicated the object of Observable class
         possibly created in another view
         
         For example,
         @ObservedObject var user = User()
         
         EnvironmentObject - allows sharing the ObservableObject in multiple screens
         must be provided by encestor
         
         @EnvironmentObject var user : User
         
         */
    
    @StateObject var user = User()
    
    var body: some View {
        switch authflow {
        case .signIn:
            SignInScreen(authFlow: $authflow)
                .environmentObject(user) // injecting the observableObject to SignInScreen
        case .signUp:
            SignUpScreen(authFlow: $authflow)
                .environmentObject(user)
        case .home:
            Home_Screen(authFlow: $authflow)
                .environmentObject(user)
        }
        
    }
}

#Preview {
    ContentView()
}
