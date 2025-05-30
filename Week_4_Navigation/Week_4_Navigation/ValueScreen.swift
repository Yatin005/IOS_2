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
    }
}

#Preview {
    ValueScreen(fruit: Fruit(name : "Mango"))
}
