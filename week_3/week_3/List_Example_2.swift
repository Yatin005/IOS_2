//
//  List_Example_2.swift
//  week_3
//
//  Created by Yatin Parulkar on 2025-05-23.
//

import SwiftUI

struct List_Example_2: View {
    
    @State private var hyperCars = Car.hyperCarList()
    
    var body: some View {
        VStack {
            DisclosureGroup("Hyper Cars"){
                ForEach(hyperCars){ car in
                }
                .listRowSeparator(.visible)
                .listRowBackground(
                    Capsule()
                        .fill(Color.teal).padding(2)
                )
            }
        }
    }
}

#Preview {
    List_Example_2()
}
