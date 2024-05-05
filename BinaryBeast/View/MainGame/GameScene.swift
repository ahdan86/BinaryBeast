//
//  GameScene.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 30/04/24.
//

import SpriteKit
import CoreMotion

enum CollisionType: UInt32 {
    case player = 1
    case bullet = 2
    case monster = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var heroNode: SKSpriteNode?
    var buttonPauseNode: SKSpriteNode?
    var buttonXNode: SKSpriteNode?
    var button1Node: SKSpriteNode?
    var button0Node: SKSpriteNode?
    var minuteLabel = SKLabelNode(text: "00:00")
    var timer = Timer()
    var VPW: CGFloat?
    var VPH: CGFloat?
    
    let moveJoystick = TLAnalogJoystick(withDiameter: 100)
    var directionShoot: SKSpriteNode?
    
    var isPlayerAlive = true
    var levelNumber = 1
    var playerHealth = 100
      
    override func didMove(to view: SKView) {
        self.scene?.physicsWorld.contactDelegate = self
        view.isMultipleTouchEnabled = true
        
        VPW = view.frame.width
        VPH = view.frame.height
        addBackground()
        addHero()
        addJoystick()
        addButton()
        addEventHandler()
        timerStart()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            if touchedNode.name == "button0" {
              shotBullet(binaryNumber: 0, bulletAttack: true)
            } else if touchedNode.name == "button1" {
              shotBullet(binaryNumber: 1, bulletAttack: true)
            } else if touchedNode.name == "buttonX" {
              shotBullet(binaryNumber: nil, bulletAttack: false)
            } else if touchedNode.name == "buttonPause" {
              print("paused")
            }
        }
    }
    
    func shotBullet(binaryNumber: Int?, bulletAttack: Bool) {
        let shot = BulletNode(bulletAttack: bulletAttack, binaryNumber: binaryNumber, impulse: 150.0)
        shot.position = directionShoot!.position
        shot.zRotation = directionShoot!.zRotation
        shot.physicsBody?.velocity.dx = shot.impulse * cos(directionShoot!.zRotation + CGFloat.pi / 2)
        shot.physicsBody?.velocity.dy = shot.impulse * sin(directionShoot!.zRotation + CGFloat.pi / 2)
        addChild(shot)
    }
    
    func addHero() {
        let hero = HeroNode()
        hero.position = CGPoint(x: VPW!/2, y: VPH!/2)
        
        guard let triangleImage = UIImage(named: "directiontarget") else {
            return
        }
        
        let triangleTexture = SKTexture(image: triangleImage)
        let triangle = SKSpriteNode(texture: triangleTexture)
        triangle.scale(to: CGSize(width: 20, height: 20))
        triangle.position = CGPoint(x: hero.position.x, y: hero.position.y + 50)
        
        addChild(hero)
        heroNode = hero
        addChild(triangle)
        directionShoot = triangle
    }
    
    func addBackground() {
        let background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: VPW! / 2, y: VPH! / 2)
        addChild(background)
    }
    
    func addJoystick() {
        let moveJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: -90, y: -90, width: frame.width, height: frame.height))

        
        guard let stickImage = UIImage(named: "analog_stick") else {
            return
        }
        guard let joystickOuterImage = UIImage(named: "analog_outer") else {
            return
        }
        moveJoystick.handleImage = stickImage
        moveJoystick.baseImage = joystickOuterImage
        moveJoystick.isMoveable = false
        moveJoystickHiddenArea.joystick = moveJoystick
        moveJoystickHiddenArea.position = CGPoint(x: 90, y: 90)
        moveJoystickHiddenArea.zPosition = 99
        addChild(moveJoystickHiddenArea)
    }
    
    func addEventHandler() {
        moveJoystick.on(.move) { [unowned self] joystick in
            let degree = joystick.angular * 180 / CGFloat.pi
            let newDegree = degree + 90
            let newAngular = newDegree * CGFloat.pi / 180
            let distance = CGFloat(50)
            
            directionShoot!.position = CGPoint(x: heroNode!.position.x + distance * cos(newAngular), y: heroNode!.position.y + distance * sin(newAngular))
            directionShoot!.zRotation = joystick.angular
        }
    }
    
    func addButton() {
        let buttonWidth = VPW != nil ? VPW!/4 - 25 : 91
        let buttonHeight = VPW != nil ? buttonWidth/1.2 : 75
        
        //Button 0
        let button0Texture = SKTexture(imageNamed: "button0idle")
        let button0 = SKSpriteNode(texture: button0Texture)
        button0.scale(to: CGSize(width: buttonWidth, height: buttonHeight))
        button0.position = CGPoint(x: VPW! - 2 * buttonWidth, y: 90)
        button0.zPosition = 99
        
        // Button 1
        let button1Texture = SKTexture(imageNamed: "button1idle")
        let button1 = SKSpriteNode(texture: button1Texture)
        button1.scale(to: CGSize(width: buttonWidth, height: buttonHeight))
        button1.position = CGPoint(x: VPW! - buttonWidth + 10, y: 90 * 2 - 20)
        button1.zPosition = 99
        
        // Button X
        let buttonResetTexture = SKTexture(imageNamed: "resetButton")
        let buttonReset = SKSpriteNode(texture: buttonResetTexture)
        buttonReset.scale(to: CGSize(width: 60, height: 60))
        buttonReset.position = CGPoint(x: VPW! - 70 + 10, y: 90)
        buttonReset.zPosition = 99
        
        //Button Pause
        let buttonPauseTexture = SKTexture(imageNamed: "pauseButton")
        let buttonPause = SKSpriteNode(texture: buttonPauseTexture)
        buttonPause.scale(to: CGSize(width: 60, height: 60))
        buttonPause.position = CGPoint(x: 77, y: VPH! - 77)
        buttonPause.zPosition = 99
        
        addChild(button0)
        addChild(button1)
        addChild(buttonReset)
        addChild(buttonPause)
        button0Node = button0
        button1Node = button1
        buttonXNode = buttonReset
        buttonPauseNode = buttonPause
        button0Node!.name = "button0"
        button1Node!.name = "button1"
        buttonXNode!.name = "buttonX"
        buttonPauseNode!.name = "buttonPause"
    }

    override func update(_ currentTime: TimeInterval) {
        for child in children {
            if child.frame.maxX < 0 || child.frame.maxX > VPW! {
                if !frame.intersects(child.frame) {
                    child.removeFromParent()
                }
            }
            
            if child.frame.maxY < 0 || child.frame.maxY > VPH! {
                if !frame.intersects(child.frame) {
                    child.removeFromParent()
                }
            }
        }
        
    }
    
    func timerStart() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            self.spawnMonster()
        })
    }
    
    func spawnMonster() {
        
        // Add Monster
        let randomMonster = Int.random(in: 1..<6)
        let randomDecimal = Int.random(in: 0..<16)
        let monster = MonsterNode(decimalNumber: randomDecimal, monsterNumber: randomMonster)
        
        let topCoordinates: [CGPoint] = [
            CGPoint(x: VPW! / 4, y: VPH! + 50),
            CGPoint(x: VPW! / 2, y: VPH! + 50),
            CGPoint(x: 3 * VPW! / 4, y: VPH! + 50)
        ]

        let leftCoordinates: [CGPoint] = [
            CGPoint(x: -50, y: VPH! / 4),
            CGPoint(x: -50, y: VPH! / 2),
            CGPoint(x: -50, y: 3 * VPH! / 4)
        ]

        let rightCoordinates: [CGPoint] = [
            CGPoint(x: VPW! + 50, y: VPH! / 4),
            CGPoint(x: VPW! + 50, y: VPH! / 2),
            CGPoint(x: VPW! + 50, y: 3 * VPH! / 4)
        ]

        let bottomCoordinates: [CGPoint] = [
            CGPoint(x: VPW! / 4, y: -50),
            CGPoint(x: VPW! / 2, y: -50),
            CGPoint(x: 3 * VPW! / 4, y: -50)
        ]
        
        let allCoordinates = topCoordinates + leftCoordinates + rightCoordinates + bottomCoordinates
        
//        let randomIndex = Int.random(in: 0..<allCoordinates.count)
//        let random = allCoordinates[randomIndex]
//        monster.position = CGPoint(x: random.x, y: random.y)
        
        let randomX = Double.random(in: 0..<VPW!)
        let randomY = Double.random(in: 0..<VPH!)
        monster.position = CGPoint(x: randomX, y: randomY)
        let spawnLocation = monster.position
        
//        let dx = heroNode!.position.x - monster.position.x
//        let dy = heroNode!.position.y - monster.position.y
//        
//        monster.physicsBody?.applyForce(CGVector(dx: dx, dy: dy))
        monster.configureMovement(fromLocation: spawnLocation, toLocation: heroNode!.position)
        
        addChild(monster)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        let sortedNodes = [nodeA, nodeB].sorted { $0.name ?? "" < $1.name ?? "" }
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
//        print(firstNode)
//        print(secondNode)

        if firstNode.name == "monster" && secondNode.name == "player" {
            monsterHitPlayer(monsterNode: firstNode)
        } else if firstNode.name == "bullet" && secondNode.name == "monster" {
            bulletHitMonster(bulletNode: firstNode, monsterNode: secondNode)

            firstNode.removeFromParent()
        }
    }
    
    func monsterHitPlayer(monsterNode: SKNode) {
        print("Monster hit hero")
        
        guard isPlayerAlive else { return }

        if let explosion = SKEmitterNode(fileNamed: "Explosion") {
            explosion.position = heroNode!.position
            addChild(explosion)
        }

        playerHealth -= 10

        if playerHealth <= 0 {
            gameOver()
            heroNode!.removeFromParent()
        }
    }
    
    func bulletHitMonster(bulletNode: SKNode, monsterNode: SKNode) {
        print("Bullet hit monster")
        let bullet = bulletNode as! BulletNode
        let monster = monsterNode as! MonsterNode
        if bullet.bulletAttack {
            let countBulletCollected = 4 - monster.bulletCollected.filter { $0 == nil }.count
            if countBulletCollected < 3{
                monster.addBulletValue(bulletValue: bullet.binaryNumber!)
                monster.addPlayLabel()
            } else {
                monster.addBulletValue(bulletValue: bullet.binaryNumber!)
                print(monster.countResult())
                if monster.countResult() {
                    if let explosion = SKEmitterNode(fileNamed: "Explosion") {
                        explosion.position = monster.position
                        addChild(explosion)
                    }
                    monster.removeFromParent()
                } else {
                    playerHealth -= 10
                    monster.bulletCollected = [nil, nil, nil, nil]
                }
            }
        } else {
            monster.bulletCollected = [nil, nil, nil, nil]
            monster.removePlayLabel(success: nil)
        }
    }
    
    func gameOver() {
        isPlayerAlive = false

        if let explosion = SKEmitterNode(fileNamed: "Explosion") {
            explosion.position = heroNode!.position
            addChild(explosion)
        }

        let gameOver = SKSpriteNode(imageNamed: "gameOver")
        addChild(gameOver)
    }
}
