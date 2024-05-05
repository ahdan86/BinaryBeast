//
//  MonsterNode.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 01/05/24.
//

import SpriteKit

class MonsterNode: SKSpriteNode {
    var decimalNumber: Int
    var monsterNumber: Int
    var bulletCollected: [Int?] = [nil, nil, nil, nil]
    var bulletImageCollected: [SKNode?] = [nil, nil, nil, nil]
    var playLabel: SKShapeNode?
    
    init(decimalNumber: Int, monsterNumber: Int) {
        self.decimalNumber = decimalNumber
        self.monsterNumber = monsterNumber
        let texture = SKTexture(imageNamed: "monster" + String(monsterNumber) + "static")
        super.init(texture: texture, color: .white, size: CGSize(width: 58, height: 65))
        
        physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: 58, height: 65))
        physicsBody?.affectedByGravity = false
        physicsBody?.friction = 0.0
        physicsBody?.categoryBitMask = CollisionType.monster.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = CollisionType.bullet.rawValue

        name = "monster"
        addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel() {
        let label = SKLabelNode(fontNamed: "SF Pro")
        label.text = String(decimalNumber)
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.fontSize = 16.0
        label.zPosition = 1
        label.position = CGPoint(x: 0, y: 40)

        let background = SKShapeNode()
        background.path = UIBezierPath(roundedRect: CGRect(x: -15, y: -15, width: 30, height: 30), cornerRadius: 5).cgPath
        background.fillColor = .red
        background.lineWidth = 0
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -1
        label.addChild(background)
        addChild(label)
    }
    
    func configureMovement(fromLocation: CGPoint, toLocation: CGPoint) {
        let path = UIBezierPath()
        path.move(to: fromLocation)
        path.addLine(to: toLocation)

        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        run(sequence)
    }
    
    
    func addPlayLabel() {
        
        if(playLabel != nil ){
            if intersects(playLabel!){
                playLabel!.removeFromParent()
            }
        }
        
        // display label image
        let temp = SKShapeNode()
        temp.path = UIBezierPath(roundedRect: CGRect(x: -65, y: -20, width: 140, height: 30), cornerRadius: 5).cgPath
        temp.fillColor = .white
        temp.lineWidth = 0
        temp.position = CGPoint(x: 0, y: -30)
        temp.zPosition = 1
        playLabel = temp
        
        addChild(playLabel!)
        
        let spacing = 5
        
        for (index, value) in bulletCollected.enumerated() {
            if(value != nil) {
                let buttonImage = SKSpriteNode()
                let texture = SKTexture(imageNamed: "button" + String(value!) + "idle")
                buttonImage.texture = texture
                buttonImage.size = CGSize(width: 25, height: 25)
                buttonImage.position = CGPoint(x: -35 + index * 25 + (index - 1) * spacing, y: -5)
                buttonImage.zPosition = 2
                playLabel!.addChild(buttonImage)
            }
            else {
                let shape = SKShapeNode()
                shape.path = UIBezierPath(roundedRect: CGRect(x: -12.5, y: -12.5, width: 25, height: 25), cornerRadius: 5).cgPath
                shape.fillColor = .white
                shape.strokeColor = .black
                shape.lineWidth = 1
                shape.position = CGPoint(x: -35 + index * 25 + (index - 1) * spacing, y: -5)
                shape.zPosition = 2
                playLabel!.addChild(shape)
            }
        }
    }
    
    func removePlayLabel(success: Bool?) {
        if(success != nil) {
            if(success!){
                
            } else {
                
            }
        } else {
            playLabel!.removeFromParent()
            playLabel = nil
        }
    }
    
    func addBulletValue(bulletValue: Int) {
        let index = bulletCollected.firstIndex(of: nil)
        bulletCollected[index!] = bulletValue
    }
    
    func countResult() -> Bool {
        var tempNumber = 0
        
        for (index, value) in bulletCollected.enumerated()
        {
            if value == 1 {
                tempNumber += Int(pow(2, Double(bulletCollected.count - index - 1)))
            }
        }
        print("decimal number: \(decimalNumber), temp number: \(tempNumber)")
        return tempNumber == decimalNumber
    }

}
