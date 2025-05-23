//
//  ContentView.swift
//  week_3
//
//  Created by Yatin Parulkar on 2025-05-23.
//

import SwiftUI

struct ContentView: View {
    @State private var birthDate : Date = Date.now
    var body: some View {
        VStack {
            
            DatePicker("Birthdate : ", selection: $birthDate,in: ...Calendar.current.date(byAdding: .year, value: -16, to: Date.now)!,displayedComponents: .date)
                .datePickerStyle(.automatic)
            
            Text("Birthdate : \(birthDate)" )
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            List_Exapmle()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

