//
//  GameScene.swift
//  ChipTradeSpriteKitVer
//
//  Created by David Cao on 7/12/20.
//  Copyright © 2020 David Cao. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // ----- Initializing sprites -----
    
    // Player (non-sprite)
    let thePlayer = Player()
    
    // Turn tracker and label
    var turnCount = 1
    var turnLabel: SKLabelNode!
    
    // chip nodes
    var chipOne, chipTwo, chipThree, chipFour, chipFive, chipSix, chipSeven: SKSpriteNode!
    
    // healthBar node
    var healthBar: SKSpriteNode!
    // power-up nodes
    var skullButton, bandageButton, scaleButton, palButton: SKSpriteNode!
    // power-up uses nodes
    var skullUse, bandageUse, scaleUse, palUse: SKLabelNode!
    // roll button node
    var rollButton: SKSpriteNode!
    // trade button node
    var tradeButton: SKSpriteNode!
    // result label node
    var resultLabel: SKLabelNode!
    // card nodes (hidden)
    var cardOne, cardTwo, cardThree, cardFour, cardFive, cardSix, cardSeven, cardEight: SKSpriteNode!
    // d4 node (hidden)
    var d4: SKSpriteNode!
    // gear node
    var gearButton: SKSpriteNode!
    
    // Game Complete Variable
    var gameComplete = false
    
    // Current Active Prompt Variable
    var currPrompt = "NONE"
    
    // Default available amount of chips up for trade
    var tradeCount = 3
    // Use for comparison for trade confirmation
    var startingTradeCount = 0
    
    // Temp Trade Nums
    var currGreenNum = 0
    var currRedNum = 0
    var currPurpleNum = 0
    var currBlueNum = 0
    
    // Dim panel node
    var dimPanel: SKSpriteNode!
    
    // Power pop-up tile node
    var powerPopUp: SKSpriteNode!
    // Other power pop-up nodes
    var popPromptLabel: SKLabelNode!
    var popSkullButton, popBandageButton, popScaleButton, popPalButton: SKSpriteNode!
    var popSkullUse, popBandageUse, popScaleUse, popPalUse: SKLabelNode!
    var popCancelButton: SKSpriteNode!
    
    // Protected turns label and counter nodes
    var protectTurnsLabel, protectTurnsCounter: SKLabelNode!
    
    // Trade pop-up tile node
    var tradeBackground: SKSpriteNode!
    // Other trade pop-up nodes
    var popTradeLabel, availableChips: SKLabelNode!
    var popSkullTrade, popBandageTrade, popScaleTrade, popPalTrade: SKSpriteNode!
    var popCancelTrade, popConfirmTrade: SKSpriteNode!
    var greenUp, greenDown, redUp, redDown, purpleUp, purpleDown, blueUp, blueDown: SKSpriteNode!
    var greenNum, greenUse, redNum, redUse, purpleNum, purpleUse, blueNum, blueUse: SKLabelNode!
    
    
    override func didMove(to view: SKView) {
        // ----- Linking nodes with UI elements -----
        
        // Turn Counter Label
        turnLabel = self.childNode(withName: "turnLabel") as? SKLabelNode
        
        // Chips
        chipOne = self.childNode(withName: "chipOne") as? SKSpriteNode
        chipTwo = self.childNode(withName: "chipTwo") as? SKSpriteNode
        chipThree = self.childNode(withName: "chipThree") as? SKSpriteNode
        chipFour = self.childNode(withName: "chipFour") as? SKSpriteNode
        chipFive = self.childNode(withName: "chipFive") as? SKSpriteNode
        chipSix = self.childNode(withName: "chipSix") as? SKSpriteNode
        chipSeven = self.childNode(withName: "chipSeven") as? SKSpriteNode
        // Health Bar
        healthBar = self.childNode(withName: "healthBar") as? SKSpriteNode
        // Power-Ups
        skullButton = self.childNode(withName: "skullButton") as? SKSpriteNode
        skullUse = self.childNode(withName: "skullUse") as? SKLabelNode
        bandageButton = self.childNode(withName: "bandageButton") as? SKSpriteNode
        bandageUse = self.childNode(withName: "bandageUse") as? SKLabelNode
        palButton = self.childNode(withName: "palButton") as? SKSpriteNode
        palUse = self.childNode(withName: "palUse") as? SKLabelNode
        scaleButton = self.childNode(withName: "scaleButton") as? SKSpriteNode
        scaleUse = self.childNode(withName: "scaleUse") as? SKLabelNode
        // Action Buttons
        rollButton = self.childNode(withName: "rollButton") as? SKSpriteNode
        // Trade button
        tradeButton = self.childNode(withName: "tradeButton") as? SKSpriteNode
        // Result Label
        resultLabel = self.childNode(withName: "resultLabel") as? SKLabelNode
        // Cards
        cardOne = self.childNode(withName: "cardOne") as? SKSpriteNode
        cardTwo = self.childNode(withName: "cardTwo") as? SKSpriteNode
        cardThree = self.childNode(withName: "cardThree") as? SKSpriteNode
        cardFour = self.childNode(withName: "cardFour") as? SKSpriteNode
        cardFive = self.childNode(withName: "cardFive") as? SKSpriteNode
        cardSix = self.childNode(withName: "cardSix") as? SKSpriteNode
        cardSeven = self.childNode(withName: "cardSeven") as? SKSpriteNode
        cardEight = self.childNode(withName: "cardEight") as? SKSpriteNode
        // D4
        d4 = self.childNode(withName: "d4") as? SKSpriteNode
        // Gear Button
        gearButton = self.childNode(withName: "d4") as? SKSpriteNode
        // Dim Panel
        dimPanel = self.childNode(withName: "dimPanel") as? SKSpriteNode
        // Pop Up Tile
        powerPopUp = dimPanel.childNode(withName: "powerPopUp") as? SKSpriteNode
        // Children of Pop Up Tile
        popPromptLabel = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popPromptLabel") as? SKLabelNode
        popSkullButton = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popSkullButton") as? SKSpriteNode
        popSkullUse = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popSkullUse") as? SKLabelNode
        popBandageButton = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popBandageButton") as? SKSpriteNode
        popBandageUse = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popBandageUse") as? SKLabelNode
        popScaleButton = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popScaleButton") as? SKSpriteNode
        popScaleUse = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popScaleUse") as? SKLabelNode
        popPalButton = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popPalButton") as? SKSpriteNode
        popPalUse = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popPalUse") as? SKLabelNode
        popCancelButton = dimPanel.childNode(withName: "powerPopUp")?.childNode(withName: "popCancelButton") as? SKSpriteNode
        // Protected Turns Label & Counter
        protectTurnsLabel = self.childNode(withName: "protectTurnsLabel") as? SKLabelNode
        protectTurnsCounter = self.childNode(withName: "protectTurnsCounter") as? SKLabelNode
        // Trade Pop-Up Tile
        tradeBackground = dimPanel.childNode(withName: "tradeBackground") as? SKSpriteNode
        // Children of Trade Pop-Up Tile
        popTradeLabel = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "popTradeLabel") as? SKLabelNode
        availableChips = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "availableChips") as? SKLabelNode
        popSkullTrade = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "popSkullTrade") as? SKSpriteNode
        popBandageTrade = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "popBandageTrade") as? SKSpriteNode
        popScaleTrade = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "popScaleTrade") as? SKSpriteNode
        popPalTrade = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "popPalTrade") as? SKSpriteNode
        popCancelTrade = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "popCancelTrade") as? SKSpriteNode
        popConfirmTrade = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "popConfirmTrade") as? SKSpriteNode
        // Arrows
        greenUp = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "greenUp") as? SKSpriteNode
        greenDown = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "greenDown") as? SKSpriteNode
        redUp = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "redUp") as? SKSpriteNode
        redDown = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "redDown") as? SKSpriteNode
        purpleUp = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "purpleUp") as? SKSpriteNode
        purpleDown = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "purpleDown") as? SKSpriteNode
        blueUp = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "blueUp") as? SKSpriteNode
        blueDown = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "blueDown") as? SKSpriteNode
        // Use Labels
        greenNum = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "greenNum") as? SKLabelNode
        greenUse = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "greenUse") as? SKLabelNode
        redNum = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "redNum") as? SKLabelNode
        redUse = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "redUse") as? SKLabelNode
        purpleNum = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "purpleNum") as? SKLabelNode
        purpleUse = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "purpleUse") as? SKLabelNode
        blueNum = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "blueNum") as? SKLabelNode
        blueUse = dimPanel.childNode(withName: "tradeBackground")?.childNode(withName: "blueUse") as? SKLabelNode
    }
    
    // ----- Player Action Inputs -----
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            // Array to store the location of UI nodes
            let nodesArray = self.nodes(at: location)
            
            // Card Array (To track card display on Gameboard UI)
            let cardArray = [cardOne, cardTwo, cardThree, cardFour, cardFive, cardSix, cardSeven, cardEight]
            
            // Chip Array (To track chip display on Gameboard UI)
            let chipArray = [chipOne, chipTwo, chipThree, chipFour, chipFive, chipSix, chipSeven]
            
            // Power Button Arrays with their uses
            let buttonArr = [skullButton, bandageButton, scaleButton, palButton]
            let useArr = [skullUse, bandageUse, scaleUse, palUse]
            let popButtonArr = [popSkullButton, popBandageButton, popScaleButton, popPalButton]
            let popUseArr = [popSkullUse, popBandageUse, popScaleUse, popPalUse]
            // Trade Pop-Up Use Array
            let tradeUseArr = [greenUse, redUse, purpleUse, blueUse]
            // Trade Arrow Up and Down Arrays
            let arrowUpArr = [greenUp, redUp, purpleUp, blueUp]
            let arrowDownArr = [greenDown, redDown, purpleDown, blueDown]
            
            
            // ----- Roll Action -----
            if (nodesArray.first?.name == "rollButton") && (gameComplete == false){
                // Disables user touch until turn ends
                self.view?.isUserInteractionEnabled = false
                // Rolls chips (returns the amount faced up)
                let facedUp = rollChips(thePlayer: thePlayer, chipArray: chipArray)
                resultLabel.text = String(facedUp) + " faced up!"
                
                // Delayed code execution so first result label gets displayed
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    // -- Roll Result Cases --
                    
                    // All 7 faced up or down case:
                    if (facedUp == 7) || ((facedUp == 0) && (self.thePlayer.chipAmt == 7)){
                        self.resultLabel.text = "Lucky 7!"
                        addCards(thePlayer: self.thePlayer, cardArray: cardArray, addAmt: 3)
                    }
                    // All 6 or less chips faced up case (Reveal prompt):
                    else if (facedUp == self.thePlayer.chipAmt) && (self.thePlayer.protectedRolls == 0) && (self.thePlayer.chipAmt != 1){
                        self.resultLabel.text = "All chips faced up! +1 Card"
                        addCards(thePlayer: self.thePlayer, cardArray: cardArray, addAmt: 1)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                            powerPrompt(dimPanel: self.dimPanel, buttonArr: buttonArr, useArr: useArr, popButtonArr: popButtonArr, popUseArr: popUseArr, promptType: "allUpPrompt")
                            self.popPromptLabel.text = "Select a Power-Up to gain"
                            self.currPrompt = "allUpPrompt"
                        }
                        // Awaits user touch... go to "*Power-Up Choice" section
                    }
                    // All 6 or less chips faced down case:
                    else if (facedUp == 0) && (self.thePlayer.protectedRolls == 0) && (self.thePlayer.chipAmt != 1){
                        self.resultLabel.text = "All chips faced down! +1 Chip"
                        addChips(thePlayer: self.thePlayer, chipArray: chipArray, addAmt: 1)
                        updateHealthBar(thePlayer: self.thePlayer, healthBar: self.healthBar)
                    }
                    // Even faced up case:
                    else if(facedUp % 2) == 0{
                        // Checks if the Chip Amount the player has is 1
                        if (self.thePlayer.chipAmt != 1){
                            self.resultLabel.text = "Even Roll! +1 Card"
                            addCards(thePlayer: self.thePlayer, cardArray: cardArray, addAmt: 1)
                        }
                        else{
                            self.resultLabel.text = "Saved from death! +1 Chip"
                            addChips(thePlayer: self.thePlayer, chipArray: chipArray, addAmt: 1)
                            updateHealthBar(thePlayer: self.thePlayer, healthBar: self.healthBar)
                        }
                    }
                    // Odd faced up case:
                    else{
                        if (self.thePlayer.protectedRolls == 0){
                            self.resultLabel.text = "Odd Roll! -1 Chip"
                            reduceChips(thePlayer: self.thePlayer, chipArray: chipArray, reduceAmt: 1)
                            updateHealthBar(thePlayer: self.thePlayer, healthBar: self.healthBar)
                            if (self.thePlayer.cardAmt > 0){
                                self.resultLabel.text = "Odd Roll! -1 Chip & Card"
                                removeCards(thePlayer: self.thePlayer, cardArray: cardArray, removeAmount: 1)
                            }
                        }
                        else{
                            self.resultLabel.text = "The Shield protects you"
                        }
                    }
                    // Checks to see if Paladin's Shield is active; reduce protectedRolls if so
                    if (self.thePlayer.protectedRolls > 0){
                        self.thePlayer.protectedRolls -= 1
                        self.protectTurnsCounter.text = String(self.thePlayer.protectedRolls)
                        if (self.thePlayer.protectedRolls == 0){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                                self.resultLabel.text = "The Shield no longer guards you"
                                // Hide protected turns labels
                                self.protectTurnsLabel.isHidden = true
                                self.protectTurnsCounter.isHidden = true
                            }
                        }
                    }
                    // End of turn
                    // Check if game finished
                    self.gameComplete = checkGameResult(player: self.thePlayer, resultLabel: self.resultLabel)
                    if (self.gameComplete == false){
                        self.turnCount += 1
                        self.turnLabel.text = "TURN " + String(self.turnCount)
                        // Checks for power conditions and updates Gameboard UI accordingly
                        powerCheck(thePlayer: self.thePlayer, buttonArr: buttonArr, tradeButton: self.tradeButton)
                    }
                    self.view?.isUserInteractionEnabled = true
                }
            }
            
            // *Power-Up Choice (All 6 or less faced up case)
            else if (nodesArray.first?.name == "popSkullButton") && (currPrompt == "allUpPrompt"){
                thePlayer.skullUse += 1
                updatePwrUseLabel(powerUse: thePlayer.skullUse, powerUseLabel: useArr[0])
                // Dismiss pop-up
                dimPanel.isHidden = true
                powerPopUp.isHidden = true
                self.resultLabel.text = "+1 Green Skull use"
                powerCheck(thePlayer: thePlayer, buttonArr: buttonArr, tradeButton: tradeButton)
            }
            else if (nodesArray.first?.name == "popBandageButton") && (currPrompt == "allUpPrompt"){
                self.thePlayer.bandageUse += 1
                updatePwrUseLabel(powerUse: self.thePlayer.bandageUse, powerUseLabel: useArr[1])
                // Dismiss pop-up
                self.dimPanel.isHidden = true
                powerPopUp.isHidden = true
                self.resultLabel.text = "+1 Red Bandage use"
                powerCheck(thePlayer: thePlayer, buttonArr: buttonArr, tradeButton: tradeButton)
            }
            else if (nodesArray.first?.name == "popScaleButton") && (currPrompt == "allUpPrompt"){
                self.thePlayer.scaleUse += 1
                updatePwrUseLabel(powerUse: self.thePlayer.scaleUse, powerUseLabel: useArr[2])
                // Dismiss pop-up
                self.dimPanel.isHidden = true
                powerPopUp.isHidden = true
                self.resultLabel.text = "+1 Libra's Scale use"
                powerCheck(thePlayer: thePlayer, buttonArr: buttonArr, tradeButton: tradeButton)
            }
            else if (nodesArray.first?.name == "popPalButton") && (currPrompt == "allUpPrompt"){
                self.thePlayer.palUse += 1
                updatePwrUseLabel(powerUse: self.thePlayer.palUse, powerUseLabel: useArr[3])
                // Dismiss pop-up
                self.dimPanel.isHidden = true
                powerPopUp.isHidden = true
                self.resultLabel.text = "+1 Paladin's Shield use"
                powerCheck(thePlayer: thePlayer, buttonArr: buttonArr, tradeButton: tradeButton)
            }
            
            // ----- Red Bandage -----
            else if (nodesArray.first?.name == "bandageButton") && (thePlayer.bandageUse > 0) && (thePlayer.graveYrdAmt >= 2) && (thePlayer.protectedRolls == 0) && (gameComplete == false){
                self.view?.isUserInteractionEnabled = false
                redBandage(thePlayer: thePlayer, resultLabel: resultLabel, chipArray: chipArray, healthBar: healthBar, bandageUse: useArr[1]!, d4: d4)
                // End of turn
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0){
                    // Check if game finished
                    self.gameComplete = checkGameResult(player: self.thePlayer, resultLabel: self.resultLabel)
                    if (self.gameComplete == false){
                        self.turnCount += 1
                        self.turnLabel.text = "TURN " + String(self.turnCount)
                        // Checks for power conditions and updates Gameboard UI accordingly
                        powerCheck(thePlayer: self.thePlayer, buttonArr: buttonArr, tradeButton: self.tradeButton)
                    }
                    self.view?.isUserInteractionEnabled = true
                }
            }
            
            // ----- Green Skull -----
            else if (nodesArray.first?.name == "skullButton") && (thePlayer.skullUse > 0) && (thePlayer.graveYrdAmt >= 2) && (thePlayer.protectedRolls == 0) && (gameComplete == false){
                self.view?.isUserInteractionEnabled = false
                greenSkull(thePlayer: thePlayer, resultLabel: resultLabel, chipArray: chipArray, healthBar: healthBar, cardArray: cardArray, skullUse: useArr[0]!)
                // End of turn
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    // Check if game finished
                    self.gameComplete = checkGameResult(player: self.thePlayer, resultLabel: self.resultLabel)
                    if(self.gameComplete == false){
                        self.turnCount += 1
                        self.turnLabel.text = "TURN " + String(self.turnCount)
                        // Checks for power conditions and updates Gameboard UI accordingly
                        powerCheck(thePlayer: self.thePlayer, buttonArr: buttonArr, tradeButton: self.tradeButton)
                    }
                    self.view?.isUserInteractionEnabled = true
                }
            }
            
            // ----- Libra's Scale -----
            else if (nodesArray.first?.name == "scaleButton") && (thePlayer.scaleUse > 0) && (thePlayer.protectedRolls == 0) && (gameComplete == false){
                self.view?.isUserInteractionEnabled = false
                libraScale(thePlayer: thePlayer, resultLabel: resultLabel, chipArray: chipArray, healthBar: healthBar, cardArray: cardArray, scaleUse: useArr[2]!, d4: d4)
                // End of turn
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0){
                    // Check if game finished
                    self.gameComplete = checkGameResult(player: self.thePlayer, resultLabel: self.resultLabel)
                    if (self.gameComplete == false){
                        self.turnCount += 1
                        self.turnLabel.text = "TURN " + String(self.turnCount)
                        powerCheck(thePlayer: self.thePlayer, buttonArr: buttonArr, tradeButton: self.tradeButton)
                    }
                    self.view?.isUserInteractionEnabled = true
                }
            }
            
            // ----- Paladin's Shield -----
            else if (nodesArray.first?.name == "palButton") && (thePlayer.palUse > 0) && (thePlayer.graveYrdAmt >= 2) && (thePlayer.protectedRolls == 0) && (thePlayer.bandageUse > 0 || thePlayer.skullUse > 0 || thePlayer.scaleUse > 0) && (gameComplete == false){
                powerPrompt(dimPanel: dimPanel, buttonArr: buttonArr, useArr: useArr, popButtonArr: popButtonArr, popUseArr: popUseArr, promptType: "palPrompt")
                popPromptLabel.text = "Choose a power to sacrifice"
                currPrompt = "palPrompt"
            }
            else if (nodesArray.first?.name == "popSkullButton") && (thePlayer.skullUse > 0) && (currPrompt == "palPrompt"){
                self.view?.isUserInteractionEnabled = false
                thePlayer.skullUse -= 1
                updatePwrUseLabel(powerUse: thePlayer.skullUse, powerUseLabel: useArr[0]!)
                // Dismiss pop-up and hide cancel button
                dimPanel.isHidden = true
                powerPopUp.isHidden = true
                popCancelButton.isHidden = true
                resultLabel.text = "-1 Green Skull use"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    // Use Paladin's Shield
                    palShield(thePlayer: self.thePlayer, resultLabel: self.resultLabel, palUse: useArr[3]!, turnsLabel: self.protectTurnsLabel, turnsCounter: self.protectTurnsCounter)
                    // End of turn
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        // Check if game finished
                        self.gameComplete = checkGameResult(player: self.thePlayer, resultLabel: self.resultLabel)
                        if (self.gameComplete == false){
                            self.turnCount += 1
                            self.turnLabel.text = "TURN " + String(self.turnCount)
                            powerCheck(thePlayer: self.thePlayer, buttonArr: buttonArr, tradeButton: self.tradeButton)
                        }
                        self.view?.isUserInteractionEnabled = true
                    }
                }
            }
            else if (nodesArray.first?.name == "popBandageButton") && (thePlayer.bandageUse > 0) && (currPrompt == "palPrompt"){
                self.view?.isUserInteractionEnabled = false
                thePlayer.bandageUse -= 1
                updatePwrUseLabel(powerUse: thePlayer.bandageUse, powerUseLabel: useArr[1])
                // Dismiss pop-up and hide cancel button
                dimPanel.isHidden = true
                powerPopUp.isHidden = true
                popCancelButton.isHidden = true
                resultLabel.text = "-1 Red Bandage use"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    // Use Paladin's Shield
                    palShield(thePlayer: self.thePlayer, resultLabel: self.resultLabel, palUse: useArr[3]!, turnsLabel: self.protectTurnsLabel, turnsCounter: self.protectTurnsCounter)
                    // End of turn
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        // Check if game finished
                        self.gameComplete = checkGameResult(player: self.thePlayer, resultLabel: self.resultLabel)
                        if (self.gameComplete == false){
                            self.turnCount += 1
                            self.turnLabel.text = "TURN " + String(self.turnCount)
                            powerCheck(thePlayer: self.thePlayer, buttonArr: buttonArr, tradeButton: self.tradeButton)
                        }
                        self.view?.isUserInteractionEnabled = true
                    }
                }
            }
            else if (nodesArray.first?.name == "popScaleButton") && (thePlayer.scaleUse > 0) && (currPrompt == "palPrompt"){
                self.view?.isUserInteractionEnabled = false
                thePlayer.scaleUse -= 1
                updatePwrUseLabel(powerUse: thePlayer.scaleUse, powerUseLabel: useArr[2])
                // Dismiss pop-up and hide cancel button
                dimPanel.isHidden = true
                powerPopUp.isHidden = true
                popCancelButton.isHidden = true
                resultLabel.text = "-1 Libra's Scale use"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    // Use Paladin's Shield
                    palShield(thePlayer: self.thePlayer, resultLabel: self.resultLabel, palUse: useArr[3]!, turnsLabel: self.protectTurnsLabel, turnsCounter: self.protectTurnsCounter)
                    // End of turn
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        // Check if game finished
                        self.gameComplete = checkGameResult(player: self.thePlayer, resultLabel: self.resultLabel)
                        if (self.gameComplete == false){
                            self.turnCount += 1
                            self.turnLabel.text = "TURN " + String(self.turnCount)
                            powerCheck(thePlayer: self.thePlayer, buttonArr: buttonArr, tradeButton: self.tradeButton)
                        }
                        self.view?.isUserInteractionEnabled = true
                    }
                }
            }
            else if (nodesArray.first?.name == "popCancelButton"){
                // Dimiss pop-up and hide cancel button
                dimPanel.isHidden = true
                powerPopUp.isHidden = true
                popCancelButton.isHidden = true
            }
                
            // ----- Trade -----
            else if (nodesArray.first?.name == "tradeButton") && ((thePlayer.scaleUse == 0) || (thePlayer.palUse == 0) || (thePlayer.skullUse == 0) || (thePlayer.bandageUse == 0)) && (thePlayer.traded == false) && (thePlayer.chipAmt > 1) && (thePlayer.protectedRolls == 0){
                tradePrompt(thePlayer: thePlayer, availableChips: availableChips, tradeCount: &tradeCount, useArr: useArr, tradeUseArr: tradeUseArr, dimPanel: dimPanel)
                startingTradeCount = tradeCount
                currPrompt = "tradePrompt"
            }
            // Canceling Trade
            else if (nodesArray.first?.name == "popCancelTrade") && (currPrompt == "tradePrompt"){
                // Trade Cancel
                tradeBackground.isHidden = true
                dimPanel.isHidden = true
                tradeCount = 3
                availableChips.text = "Available Chips: " + String(tradeCount)
                currGreenNum = 0; currRedNum = 0; currPurpleNum = 0; currBlueNum = 0
                greenNum.text = String(currGreenNum); redNum.text = String(currRedNum)
                purpleNum.text = String(currPurpleNum); blueNum.text = String(currBlueNum)
                updateArrows(arrowUpArr: arrowUpArr, arrowDownArr: arrowDownArr, tradeCount: tradeCount, currGreenNum: currGreenNum, currRedNum: currRedNum, currPurpleNum: currPurpleNum, currBlueNum: currBlueNum)
            }
            // Increment Power Uses
            else if (nodesArray.first?.name == "greenUp") && (tradeCount > 0){
                // Update textures and Labels
                tradeCount -= 1
                availableChips.text = "Available Chips: " + String(tradeCount)
                currGreenNum += 1
                greenNum.text = String(currGreenNum)
                updateArrows(arrowUpArr: arrowUpArr, arrowDownArr: arrowDownArr, tradeCount: tradeCount, currGreenNum: currGreenNum, currRedNum: currRedNum, currPurpleNum: currPurpleNum, currBlueNum: currBlueNum)
            }
            else if (nodesArray.first?.name == "redUp") && (tradeCount > 0){
                // Update textures and Labels
                tradeCount -= 1
                availableChips.text = "Available Chips: " + String(tradeCount)
                currRedNum += 1
                redNum.text = String(currRedNum)
                updateArrows(arrowUpArr: arrowUpArr, arrowDownArr: arrowDownArr, tradeCount: tradeCount, currGreenNum: currGreenNum, currRedNum: currRedNum, currPurpleNum: currPurpleNum, currBlueNum: currBlueNum)
            }
            else if (nodesArray.first?.name == "purpleUp") && (tradeCount > 0){
                // Update textures and Labels
                tradeCount -= 1
                availableChips.text = "Available Chips: " + String(tradeCount)
                currPurpleNum += 1
                purpleNum.text = String(currPurpleNum)
                updateArrows(arrowUpArr: arrowUpArr, arrowDownArr: arrowDownArr, tradeCount: tradeCount, currGreenNum: currGreenNum, currRedNum: currRedNum, currPurpleNum: currPurpleNum, currBlueNum: currBlueNum)
            }
            else if (nodesArray.first?.name == "blueUp") && (tradeCount > 0){
                // Update textures and Labels
                tradeCount -= 1
                availableChips.text = "Available Chips: " + String(tradeCount)
                currBlueNum += 1
                blueNum.text = String(currBlueNum)
                updateArrows(arrowUpArr: arrowUpArr, arrowDownArr: arrowDownArr, tradeCount: tradeCount, currGreenNum: currGreenNum, currRedNum: currRedNum, currPurpleNum: currPurpleNum, currBlueNum: currBlueNum)
            }
            // Decrement Power Uses
            else if (nodesArray.first?.name == "greenDown") && (currGreenNum > 0){
                // Update textures and Labels
                tradeCount += 1
                availableChips.text = "Available Chips: " + String(tradeCount)
                currGreenNum -= 1
                greenNum.text = String(currGreenNum)
                updateArrows(arrowUpArr: arrowUpArr, arrowDownArr: arrowDownArr, tradeCount: tradeCount, currGreenNum: currGreenNum, currRedNum: currRedNum, currPurpleNum: currPurpleNum, currBlueNum: currBlueNum)
            }
            else if (nodesArray.first?.name == "redDown") && (currRedNum > 0){
                // Update textures and Labels
                tradeCount += 1
                availableChips.text = "Available Chips: " + String(tradeCount)
                currRedNum -= 1
                redNum.text = String(currRedNum)
                updateArrows(arrowUpArr: arrowUpArr, arrowDownArr: arrowDownArr, tradeCount: tradeCount, currGreenNum: currGreenNum, currRedNum: currRedNum, currPurpleNum: currPurpleNum, currBlueNum: currBlueNum)
            }
            else if (nodesArray.first?.name == "purpleDown") && (currPurpleNum > 0){
                // Update textures and Labels
                tradeCount += 1
                availableChips.text = "Available Chips: " + String(tradeCount)
                currPurpleNum -= 1
                purpleNum.text = String(currPurpleNum)
                updateArrows(arrowUpArr: arrowUpArr, arrowDownArr: arrowDownArr, tradeCount: tradeCount, currGreenNum: currGreenNum, currRedNum: currRedNum, currPurpleNum: currPurpleNum, currBlueNum: currBlueNum)
            }
            else if (nodesArray.first?.name == "blueDown") && (currBlueNum > 0){
                // Update textures and Labels
                tradeCount += 1
                availableChips.text = "Available Chips: " + String(tradeCount)
                currBlueNum -= 1
                blueNum.text = String(currBlueNum)
                updateArrows(arrowUpArr: arrowUpArr, arrowDownArr: arrowDownArr, tradeCount: tradeCount, currGreenNum: currGreenNum, currRedNum: currRedNum, currPurpleNum: currPurpleNum, currBlueNum: currBlueNum)
            }
            
            // Confirm Trade
            else if (nodesArray.first?.name == "popConfirmTrade") && (tradeCount < startingTradeCount){
                self.view?.isUserInteractionEnabled = false
                let tradeSum = currGreenNum + currRedNum + currPurpleNum + currBlueNum
                // Hide prompt
                tradeBackground.isHidden = true
                dimPanel.isHidden = true
                resultLabel.text = "Trade Confirmed"
                // Reduce chips
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.resultLabel.text = "-" + String(tradeSum) + " Chips"
                    reduceChips(thePlayer: self.thePlayer, chipArray: chipArray, reduceAmt: tradeSum)
                    // Power uses gained
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.resultLabel.text = "Power uses gained"
                        
                        self.thePlayer.skullUse += self.currGreenNum
                        updatePwrUseLabel(powerUse: self.thePlayer.skullUse, powerUseLabel: useArr[0])
                        self.thePlayer.bandageUse += self.currRedNum
                        updatePwrUseLabel(powerUse: self.thePlayer.bandageUse, powerUseLabel: useArr[1])
                        self.thePlayer.scaleUse += self.currPurpleNum
                        updatePwrUseLabel(powerUse: self.thePlayer.scaleUse, powerUseLabel: useArr[2])
                        self.thePlayer.palUse += self.currBlueNum
                        updatePwrUseLabel(powerUse: self.thePlayer.palUse, powerUseLabel: useArr[3])
                        
                        self.thePlayer.traded = true
                        
                        // End of turn
                        self.turnCount += 1
                        self.turnLabel.text = "TURN " + String(self.turnCount)
                        powerCheck(thePlayer: self.thePlayer, buttonArr: buttonArr, tradeButton: self.tradeButton)
                        self.view?.isUserInteractionEnabled = true
                    }
                }
            }
            
            
            // ----- Gear Button (Return to main menu) -----
            else if (nodesArray.first?.name == "gearButton"){
                let transition = SKTransition.crossFade(withDuration: 1.5)
                if let menuScene = SKScene(fileNamed: "MenuScene"){
                    menuScene.scaleMode = .aspectFit
                    self.view?.presentScene(menuScene, transition: transition)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
