//
//  ContentView.swift
//  Week_4_Navigation
//
//  Created by Yatin Parulkar on 2025-05-30.
//

import SwiftUI

struct ContentView: View {
    
    // var to trigger navigation to homescreen when set to true
    @State private var showHomeScreen : Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Content View")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                //navlink to viewdetailScreen
                NavigationLink(destination: ViewDetailScreen()) {
                    Text("Go to ViewDetailScreen")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.brown)
                }
                NavigationLink(destination: ValueScreen(fruit: Fruit(name: "Guava"))) {
                    Text("Go to Value Screen")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.brown)
                        .padding(.top, 5)
                }
                NavigationLink {
                    ValueScreen(fruit: Fruit(name: "Apple"))
                } label: {
                    Text("Send apple to value screen")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.brown)
                        .padding(.top, 25)
                    
                }
                
                NavigationLink("Pineapple"){
                    ValueScreen(fruit: Fruit(name: "Pineapple"))
                }
                
                //                //value-based navigation
                //Error - No valid Navigation destination
                //                NavigationLink(value: Fruit(name: "Lytchi")){
                //                    Text("Show Lytchi")
                //                        .font(.title2)
                //                        .fontWeight(.bold)
                //                        .foregroundStyle(.teal)
                //                        .padding(.top, 25)
                //                }
                List {
                    NavigationLink("Lytchi",value: Fruit(name: "Litchi") )
                    NavigationLink("Grapes",value: Fruit(name: "Grapes") )
                    NavigationLink("Orange",value: Fruit(name: "Orange") )
                }
                
                //programmatically navLink
                
                Button {
                    // perform neessary opt to check if navlink shouble allowed or not
                    let x = 11
                    if (x > 10) {
                       // perfor naav
                        self.showHomeScreen = true
                    }
                } label: {
                    Text("Check Condition")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.indigo)
                        .padding(.horizontal, 25)
                }
                
                
                Spacer()
            } //Vstack
            .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            .navigationTitle(Text("Week - 4 - Navigation"))
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationDestination(for: Fruit.self){ fruit in
                ValueScreen(fruit: fruit)
            } //navDestination
            .navigationDestination(isPresented: $showHomeScreen) {
                HomeScreen()
            }
            .onAppear(){
                // event trigger when the view apperas on screen or comes in foreground
                //perform necessary opt such as a load data
                print(#function, "ContentView - Vstack appeared")
            }
            .onDisappear(){
                // event trigger when the view is discarded or removed fron the foreground
                // perform opt like saving/sync data, stop refreshing data
                print(#function, "ContentView - Vstack disappeared")
            }
        } // NavigationStack
        .onAppear(){
            // event trigger when the view apperas on screen or comes in foreground
            //perform necessary opt such as a load data
            print(#function, "ContentView - NavStack appeared")
        }
        .onDisappear(){
            // event trigger when the view is discarded or removed fron the foreground
            // perform opt like saving/sync data, stop refreshing data
            print(#function, "ContentView - NavStack disappeared")
        }
    } // body
} // contentView

#Preview {
    ContentView()
}
