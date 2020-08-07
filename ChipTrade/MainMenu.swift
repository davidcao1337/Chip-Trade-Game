//
//  MainMenu.swift
//  ChipTradeSpriteKitVer
//
//  Created by David Cao on 7/12/20.
//  Copyright © 2020 David Cao. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    
    var playButtonNode: SKSpriteNode!
    var settingsButtonNode:SKSpriteNode!
    var creditsButtonNode:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        playButtonNode = self.childNode(withName: "playButton") as? SKSpriteNode
        settingsButtonNode = self.childNode(withName: "settingsButton") as? SKSpriteNode
        creditsButtonNode = self.childNode(withName: "creditsButton") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "playButton" {
                let transition = SKTransition.crossFade(withDuration: 1)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
