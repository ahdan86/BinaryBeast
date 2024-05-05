//
//  BulletNode.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 02/05/24.
//

import SpriteKit

class BulletNode: SKSpriteNode {
    var bulletAttack: Bool
    var binaryNumber: Int?
    var impulse: CGFloat
    
    init(bulletAttack: Bool, binaryNumber: Int?, impulse: CGFloat) {
        self.bulletAttack = bulletAttack
        self.binaryNumber = binaryNumber
        self.impulse = impulse
        
        let texture = SKTexture(imageNamed: "playerWeapon")
        super.init(texture: texture, color: .white, size: CGSize(width: 10, height: 30))
        
        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = CollisionType.bullet.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = CollisionType.monster.rawValue
        name = "bullet"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
