//
//  ContentView.swift
//  lab9
//
//  Created by Yatin Parulkar on 2025-08-15.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
            let scene = MazeScene()
            scene.size = CGSize(width: 400, height: 400)
            scene.scaleMode = .resizeFill
            return scene
        }
        
        var body: some View {
            SpriteView(scene: scene)
                .frame(width: 400, height: 400)
                .cornerRadius(12)
                .shadow(radius: 6)
        }
}

#Preview {
    ContentView()
}
