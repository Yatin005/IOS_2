//
//  ContentView.swift
//  Lab_2
//
//  Created by Yatin Parulkar on 2025-05-23.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    
    var id : String {self.rawValue}
}

struct ContentView: View {
    
    private var kitList : [String] = [
        "survival kits",
        "radiation protection kit",
        "gas masks",
        "fire protection kits"
    ]
    
    @State private var home_Address : String = "";
    @State private var num_of_People : Int = 1;
    @State private var select_kit : String = "fire protection kits";
    @State private var isAvailabe : Bool = false
    @State private var haveKitAvailbale : Bool = false;
    @State private var alert: String = "";
    @State private var selectedTheme: AppTheme = .light
    
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
                Section(header: Text("Select Theme")) {
                    
                    Picker("Choose a Theme", selection: $selectedTheme) {
                        ForEach(AppTheme.allCases, id: \.self) { theme in
                            Text(theme.rawValue)
                        }
                    }.pickerStyle(.segmented)
                } //Section for Theme
                
                Section(header: Text("Home Address")) {
                    TextField("Enter Home Address", text: $home_Address)
                }
                Section(header: Text("Number OF People in household")) {
                    Stepper(value: $num_of_People, in: 1...10) {
                        Text("\(num_of_People)")
                    }
                }
                Section(header: Text("Have already Recieved kit.?")) {
                    Toggle("Recieved or Not ? ", isOn: $haveKitAvailbale)
                }
                Section(header: Text("Select Your Kit")) {
                    Picker("Select Your Kit ",selection: $select_kit){
                        ForEach(kitList, id: \.self) { kit in
                            Text(kit)}
                    }
                }
            }
            Button{
                if(self.home_Address.isEmpty)
                {
                    alert = "Please Enter Your Home Address"
                }
                else if (!(self.num_of_People > 0)){
                    alert = "Minimum of One kit per Household is required";
                }
                else if (self.haveKitAvailbale){
                    alert = "You already have a kit so you cannot get another kit "
                }
                else{
                    alert = "We have recieve your order for \(select_kit) and it will be processed soon and delivered at \(home_Address)";
                }
                isAvailabe = true;
            } label: {
                Text("Place Order")
            }.alert(isPresented: $isAvailabe, content: {
                Alert(
                    title: Text("Alert"),
                    message: Text(alert),
                    dismissButton: .default(Text("OK"))
                )
            }) // Alert
            
        } // Form
        .navigationTitle("Yatin Parulkar")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(colorScheme)
    } // Navstack
       
}


#Preview {
    ContentView()
}
