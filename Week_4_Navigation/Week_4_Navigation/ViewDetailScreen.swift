//
//  ViewDetailScreen.swift
//  Week_4_Navigation
//
//  Created by Yatin Parulkar on 2025-05-30.
//

import SwiftUI

struct ViewDetailScreen: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("View- Detail")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
        }
        .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.yellow)

        .navigationTitle(Text("View Detail Screen"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ViewDetailScreen()
}
