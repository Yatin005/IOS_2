//
//  ContentView.swift
//  Lab_8
//
//  Created by Yatin Parulkar on 2025-08-15.
//

import SwiftUI


struct ContentView: View {
    @StateObject var viewModel = DataViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                HStack {
                    AsyncImage(url: URL(string: item.imageurl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .frame(width: 40, height: 40)
                    }
                    Text(item.name)
                        .font(.headline)
                }
            }
            .navigationTitle("Lab_8")
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}

#Preview {
    ContentView()
}
