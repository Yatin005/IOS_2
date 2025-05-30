//
//  ContentView.swift
//  Week_4_Navigation
//
//  Created by Yatin Parulkar on 2025-05-30.
//

import SwiftUI

struct ContentView: View {
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
                        .padding(.top, 25)
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
                
                
                Spacer()
            } //Vstack
            .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

            .navigationTitle(Text("Week - 4 - Navigation"))
            .navigationBarTitleDisplayMode(.inline)
        } // navigationStack
    } // body
} // contentView

#Preview {
    ContentView()
}
