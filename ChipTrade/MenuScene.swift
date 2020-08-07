//
//  MenuScene.swift
//  ChipTradeSpriteKitVer
//
//  Created by David Cao on 7/13/20.
//  Copyright © 2020 David Cao. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var playButtonNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        playButtonNode = self.childNode(withName: "playButton") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "playButton" {
                let transition = SKTransition.crossFade(withDuration: 1.5)
                if let gameScene = SKScene(fileNamed: "GameScene"){
                    gameScene.scaleMode = .aspectFit
                    self.view?.presentScene(gameScene, transition: transition)
                }
            }
        }
    }
}
