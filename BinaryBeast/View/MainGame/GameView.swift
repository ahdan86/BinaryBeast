//
//  GameView.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 30/04/24.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    static var orientationLock = UIInterfaceOrientationMask.landscape
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .navigationBarHidden(true)
            .ignoresSafeArea()
    }
}

#Preview {
    GameView()
}
