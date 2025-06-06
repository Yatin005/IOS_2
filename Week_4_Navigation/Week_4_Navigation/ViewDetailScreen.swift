//
//  ViewDetailScreen.swift
//  Week_4_Navigation
//
//  Created by Yatin Parulkar on 2025-05-30.
//

import SwiftUI

struct ViewDetailScreen: View {
    //refreshing to dismiss env var to programmatically discard/close screen
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            Text("View- Detail Screen")
                .font(.title)
                .fontWeight(.bold)
            Button{
                dismiss()
            }label: {
                Text("Close the screen")
            }.buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.yellow)

        .navigationTitle(Text("View Detail Screen"))
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear(){
            // event trigger when the view apperas on screen or comes in foreground
            //perform necessary opt such as a load data
            print(#function, "ViewDetail Screen appeared")
        }
        .onDisappear(){
            // event trigger when the view is discarded or removed fron the foreground
            // perform opt like saving/sync data, stop refreshing data
            print(#function, "ViewDetail Screen disappeared")
        }
    }
}
#Preview {
    ViewDetailScreen()
}
