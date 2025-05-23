//
//  ContentView.swift
//  Week2_Views_Layout
//
//  Created by Yatin Parulkar on 2025-05-16.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    
    var id : String {self.rawValue}
}


let contactList : [Contact] = [
    Contact(name:"Yatin" , initial: "YT", phonenumber: "4378783994"),
    Contact(name:"Het" , initial: "HT", phonenumber: "4378743994"),
    Contact(name:"Arch" , initial: "AR", phonenumber: "4374583994"),
    Contact(name:"Yash" , initial: "YS", phonenumber: "4378673994"),
    Contact(name:"Vatsal" , initial: "VD", phonenumber: "6378783994")
]

let colors = [Color.red, Color.gray, Color.blue, Color.purple, Color.teal]


struct ContentView: View {
    
    let cities = ["Toronto", "Etobicoke", "Brampton", "Niagara"]
    @State private var selectedCity = "Brampton"
    @State private var selectedTheme: AppTheme = .light
    @State private var quantity : Int = 1
    @State private var isRegistered : Bool  = true
    
    private var colorScheme: ColorScheme {
        switch selectedTheme {
        case .light:
                .light
        case .dark:
                .dark
        }
    }
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section(header: Text("Choose a Cities")) {
                    Picker("Choose a City", selection: $selectedCity) {
                        ForEach(cities, id: \.self) { city in
                            Text(city)
                        }
                    }.pickerStyle(.menu)  // For cities
                } //Section for cities
                Section(header: Text("Select Theme")) {
                    
                    Picker("Choose a Theme", selection: $selectedTheme) {
                        ForEach(AppTheme.allCases, id: \.self) { theme in
                            Text(theme.rawValue)
                        }
                    }.pickerStyle(.segmented)     // view for MODE
                } //Section for Theme
                Section(header: Text("Quantity")) {
                    Stepper(value: $quantity, in: 1...10) {
                        Text("Quantity : \(self.quantity)")
                    }
                } //Section for quantity
                Section(header: Text("Preference")) {
                    Toggle("Registered Users ? ", isOn: $isRegistered)
                    
                } //Section for Toggle
                Section(header: Text("Layout Example")) {
                    VStack {
                        Text("VStack Content")
                            .font(.headline)
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 100)
                        //                        Circle()
                        //                            .fill(Color.gray)
                        //                            .frame(height: 70)      // Hardcode for color
                        Circle()
                            .fill(Color("Circle"))   // using Assets color
                            .frame(height: 70)
                        HStack {
                            Circle()
                                .fill(Color.black)
                                .frame(height: 70)
                            Rectangle()
                                .fill(Color.teal)
                                .frame(height: 70)
                            Circle()
                                .fill(Color.green)
                                .frame(height: 70)
                            Circle()
                                .fill(Color.red)
                                .frame(height: 70)
                        }
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.3))
                    
                    
                } //Section for Layout
                Section(header: Text("Contatc")) {
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(contactList, id: \.self) { contact in
                                VStack {
                                    ZStack{
                                        Circle()
                                            .fill(colors.randomElement()!)
                                            .frame(width:70, height: 70)
                                        Text(contact.initial)
                                            .foregroundStyle(Color.white)
                                            .font(.system(size: 28))
                                    }
                                    Text(contact.name)
                                }
                            }
                        }
                    }
                } //Section for ContactList
                Section(header: Text("Grid Example")) {
                    Grid(){
                        GridRow{
                            Text("Name")
                            Text("Initial")
                            Text("Number")
                        } .font(.title3)
                        Divider()
                        
                        ForEach(contactList) { contact in
                            GridRow(alignment: .firstTextBaseline){
                                Text(contact.name)
                                Text(contact.initial)
                                    .gridColumnAlignment(.center)
                                Text(contact.phonenumber)
                                    .gridColumnAlignment(.trailing)
                            }
                            .font(.title3)
                            Divider()
                        }
                    }
                }
            } // Form
            
            .navigationTitle("Views and Layout")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Menu {
                        Button {
                            
                        } label: {
                            Text("Reset")
                        }
                        Button {
                            selectedTheme = .dark
                        } label: {
                            Text("Set Dark Mode")
                        }
                        Button {
                            isRegistered.toggle()
                        } label: {
                            Text("Reset Switch")
                        }
                        
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.gray)
                    }
                    
                }
            } // Toolbar
            
        } // NavStack
        .preferredColorScheme(colorScheme)
    } //body
}

#Preview {
    ContentView()
}
