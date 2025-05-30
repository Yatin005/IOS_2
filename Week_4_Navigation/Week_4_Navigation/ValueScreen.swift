//
//  ValueScreen.swift
//  Week_4_Navigation
//
//  Created by Yatin Parulkar on 2025-05-30.
//

import SwiftUI

struct ValueScreen: View {
    let fruit : Fruit
    var body: some View {
        VStack(alignment: .leading){
            Text("Value - Destination Screen")
                .font( .title)
                .fontWeight(.bold)
            
            Text("Fruit : \(fruit.name)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top,  50)
            
            
            Spacer()
        }
        .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.green)

        .navigationTitle(Text("Value - Destination"))
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear(){
            // event trigger when the view apperas on screen or comes in foreground
            //perform necessary opt such as a load data
            print(#function, "Value Screen appeared")
        }
        .onDisappear(){
            // event trigger when the view is discarded or removed fron the foreground
            // perform opt like saving/sync data, stop refreshing data
            print(#function, "Value Screen disappeared")
        }
    }
}

#Preview {
    ValueScreen(fruit: Fruit(name : "Mango"))
}
