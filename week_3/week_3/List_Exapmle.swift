//
//  List_Exapmle.swift
//  week_3
//
//  Created by Yatin Parulkar on 2025-05-23.
//

import SwiftUI

struct List_Exapmle: View {
    
    @State private var cars = Car.getSampleCars()
    @State private var searchCarModel : String = ""
    var body: some View {
        NavigationStack {
            List{
                ForEach(searchCar(searchItem: searchCarModel)) {car in
                    HStack{
                        VStack(alignment: .leading){
                            Text(car.model)
                                .font(.headline)
                            
                            
                            Text(car.make)
                                .font(.subheadline)
                        }
                        Spacer()
                        Image(systemName: car.isFavorite ? "star.fill"  : "star")
                    } //HStcck
                    .onTapGesture {
                        print("Tapped Gesture: \(car.model)")
                    }
                    .onLongPressGesture(perform: {
                        print("Long Tapped \(car.make)")
                    })
                } //forEach
//                .onMove{ source , destination in
//                    cars.move(fromOffsets: source, toOffset: destination)
//                }
                .onDelete(perform: { indexSet in
                    cars.remove(atOffsets: indexSet)
                })
                .listRowBackground(
                    Capsule()
                        .fill(Color.teal)
                        .padding(3)
                )
            } //List
            .searchable(text: $searchCarModel, prompt: "Seach Car Model")
//            .listStyle(.sidebar)
            
            .navigationTitle("Yatin Parulkar")
            .navigationBarTitleDisplayMode(.inline)
        } //navstack
        
        
    }
    
    private func searchCar(searchItem: String) -> [Car] {
        if(searchItem.isEmpty) {
            //return all the cars if not searching for anything
            return cars
        } else {
            var results : [Car] = []
            
            for car in cars {
                //case sensitive
                if(car.model.contains(searchItem)) {
                    results.append(car)
                }
            }
            return results
        }
    }
}

#Preview {
    List_Exapmle()
}
