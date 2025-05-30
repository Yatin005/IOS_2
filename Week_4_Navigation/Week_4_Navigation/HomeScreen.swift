//
//  HomeScreen.swift
//  Week_4_Navigation
//
//  Created by Yatin Parulkar on 2025-05-30.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack(alignment: .leading){
            
            
            Spacer()
        }
        .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.mint)
        
        .navigationTitle(Text("Home Screen"))
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear(){
            // event trigger when the view apperas on screen or comes in foreground
            //perform necessary opt such as a load data
            print(#function, "Home Screen appeared")
        }
        .onDisappear(){
            // event trigger when the view is discarded or removed fron the foreground
            // perform opt like saving/sync data, stop refreshing data
            print(#function, "Home Screen disappeared")
        }
    }
}

#Preview {
    HomeScreen()
}
