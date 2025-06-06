//
//  ContentView.swift
//  Week_5_DataExchange
//
//  Created by Yatin Parulkar on 2025-06-06.
//

import SwiftUI

struct ContentView: View {
    @State private var authflow: AuthFlow = .signIn
    
    var body: some View {
        switch authflow {
        case .signIn:
            SignInScreen(authFlow: $authflow)
        case .signUp:
            SignupScreen(authFlow: $authflow)
        case .home:
            HomeScreen(authFlow: $authflow)
        }
        
    }
}

#Preview {
    ContentView()
}
