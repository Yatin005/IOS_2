//
//  ContentView.swift
//  Lab_5_Yatin
//
//  Created by Yatin Parulkar on 2025-06-10.
//

import SwiftUI
struct ContentView: View {
    @State private var authflow: AuthFlow = .signIn
    @StateObject var patient = Patient()

    var body: some View {
        switch authflow {
        case .signIn:
            LogInScreen(authFlow: $authflow)
                .environmentObject(patient)
        case .signUp:
            RegisterScreen(authFlow: $authflow)
                .environmentObject(patient)
        case .home:
            DashboardScreen(authFlow: $authflow)
                .environmentObject(patient)
        }
    }
}

