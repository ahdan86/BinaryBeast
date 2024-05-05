//
//  HeroNode.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 02/05/24.
//

import SpriteKit

class HeroNode: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "hero")
        
        super.init(texture: texture, color: .white, size: CGSize(width: 50, height: 50))
        
        physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: 50, height: 50))
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = CollisionType.player.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = CollisionType.monster.rawValue
        physicsBody?.isDynamic = false
        name = "hero"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
