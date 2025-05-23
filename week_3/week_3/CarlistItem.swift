//
//  CarlistItem.swift
//  week_3
//
//  Created by Yatin Parulkar on 2025-05-23.
//

import SwiftUI

struct CarlistItem: View {
    let car: Car
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(car.model)
                    .font(.headline)
                
                
                Text(car.make)
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: car.isFavorite ? "star.fill"  : "star")
        }
    }
}

