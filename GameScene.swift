//
//  GameScene.swift
//  DisasterGame
//
//  Created by Sydney Altobell on 3/3/18.
//  Copyright © 2018 Sydney Altobell. All rights reserved.
//

import SpriteKit



private let kAnimalNodeName = "movable"



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let background = SKSpriteNode(imageNamed: "room")
    
    var selectedNode = SKSpriteNode()
    
    var boxNode = SKSpriteNode()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        
        
        physicsWorld.contactDelegate = self;
        
        
        
        //3
        
        let imageNames = ["batteries", "blanket", "first_aid_kit", "food", "fruit", "hair_dryer", "hand_sanitizer", "important_documents", "medicine", "money", "multipurpose_tool", "radio", "soda", "TV", "video_game", "water_gallon"]
        
        
        
        for i in 0..<imageNames.count {
            
            let imageName = imageNames[i]
            
            
            
            let sprite = SKSpriteNode(imageNamed: imageName)
            
            print("imageName: \(imageName)")
            
            sprite.name = kAnimalNodeName
            
            sprite.alpha = 2.0
            
            
            
            let offsetFraction = (CGFloat(i) + 1.0)/(CGFloat(imageNames.count) + 1.0)
            
            
            
            sprite.position = CGPoint(x: size.width * 1.7 * offsetFraction, y: (size.height / 2 + 150 * pow(-1,CGFloat(i))))
            
            
            
            if imageName == "fruit" || imageName == "hair_dryer" || imageName == "soda" || imageName == "TV" || imageName == "video_game"{
                
                //type of object
                
                sprite.physicsBody?.categoryBitMask = 0;
                
                //objects that collide with something
                
                sprite.physicsBody?.collisionBitMask = 1;
                
                sprite.physicsBody?.contactTestBitMask = 1;
                
                sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
                
                sprite.physicsBody?.affectedByGravity = false;
                
            }
            
            
            
            background.addChild(sprite)
            
        }
        
        
        
        // 1
        
        self.background.name = "background"
        
        self.background.anchorPoint = CGPoint.zero
        
        self.background.position = CGPoint(x: -250, y: 0)
        
        self.background.alpha = 0.5
        
        
        
        boxNode = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 95, height: 60))
        
        boxNode.alpha = 10.0
        
        boxNode.isUserInteractionEnabled = false
        
        boxNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        boxNode.position = CGPoint(x: 650, y: 212.5)
        
        
        
        boxNode.physicsBody = SKPhysicsBody(circleOfRadius: boxNode.size.width/1.5)
        
        boxNode.physicsBody?.affectedByGravity = false;
        
        boxNode.physicsBody?.categoryBitMask = 1;
        
        boxNode.physicsBody?.collisionBitMask = 0;
        
        boxNode.physicsBody?.isDynamic = false;
        
        
        
        
        
        // 2
        
        self.addChild(background)
        
        background.addChild(boxNode)
        
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first as? UITouch!
        
        let positionInScene = touch?.location(in: self)
        
        
        
        selectNodeForTouch(touchLocation: positionInScene!)
        
    }
    
    
    
    func degToRad(degree: Double) -> CGFloat {
        
        return CGFloat(Double(degree) / 180.0 * Double.pi)
        
    }
    
    
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        
        // 1
        
        let touchedNode = self.atPoint(touchLocation)
        
        
        
        if touchedNode is SKSpriteNode {
            
            // 2
            
            if !selectedNode.isEqual(touchedNode) {
                
                selectedNode.removeAllActions()
                
                selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                
                
                selectedNode = touchedNode as! SKSpriteNode
                
                
                
                // 3
                
                if touchedNode.name! == kAnimalNodeName {
                    
                    let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                                                      
                                                      SKAction.rotate(byAngle: 0.0, duration: 0.1),
                                                      
                                                      SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)])
                    
                    selectedNode.run(SKAction.repeatForever(sequence))
                    
                }
                    
                else {
                    
                    
                    
                }
                
            }
            
        }
        
    }
    
    
    
    func boundLayerPos(aNewPosition: CGPoint) -> CGPoint {
        
        let winSize = self.size
        
        var retval = aNewPosition
        
        retval.x = CGFloat(min(retval.x, 0))
        
        retval.x = CGFloat(max(retval.x, -(background.size.width) + winSize.width))
        
        retval.y = self.position.y
        
        
        
        return retval
        
    }
    
    
    
    func panForTranslation(translation: CGPoint) {
        
        let position = selectedNode.position
        
        
        
        if selectedNode.name! == kAnimalNodeName {
            
            selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
            
            print("selectedNode.position: \(selectedNode.position)")
            
        } else {
            
            let aNewPosition = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
            
            background.position = self.boundLayerPos(aNewPosition: aNewPosition)
            
        }
        
    }
    
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first as? UITouch!
        
        let positionInScene = touch?.location(in: self)
        
        let previousPosition = touch?.previousLocation(in: self)
        
        let translation = CGPoint(x: (positionInScene?.x)! - (previousPosition?.x)!, y: (positionInScene?.y)! - (previousPosition?.y)!)
        
        
        
        panForTranslation(translation: translation)
        
        
        
        //        let imageNames = ["batteries", "blanket", "first_aid_kit", "food", "fruit", "hair_dryer", "hand_sanitizer", "important_documents", "medicine", "money", "multipurpose_tool", "radio", "soda", "TV", "video_game", "water_gallon"]
        
        
        
        //        for i in 0..<imageNames.count {
        
        //            let imageName = imageNames[i]
        
        //
        
        //            selectedNode = SKSpriteNode(imageNamed: imageName)
        
        //            selectedNode.name = kAnimalNodeName
        
        //            //selectedNode.alpha = 2.0
        
        //
        
        if selectedNode.position.x<695 && selectedNode.position.x>585 && selectedNode.position.y<238 && selectedNode.position.y>185 {
            
            selectedNode.removeFromParent()
            
        }
        
        if (children.count<=7){
            
            //error message or go to next slide
            
        }
        
        //&& imageName != "fruit" && imageName != "hair_dryer" && imageName != "soda" && imageName != "TV" && imageName != "video_game"
        
        //        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
}




