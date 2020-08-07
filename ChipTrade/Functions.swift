//
//  Functions.swift
//  ChipTradeSpriteKitVer
//
//  Created by David Cao on 7/14/20.
//  Copyright © 2020 David Cao. All rights reserved.
//

import Foundation
import SpriteKit


// ----- Basic roll mechanic -----
func rollChips(thePlayer: Player, chipArray: [SKSpriteNode?]) -> Int{
    var facedUp = 0
    var index = 7 - thePlayer.chipAmt
    for _ in 1...thePlayer.chipAmt{
        // Flip a chip
        let flipResult = Int.random(in: 0...1)
        // 0 = Face Down; 1 = Face Up
        // If Faced Up, set Chip to faced up on Gameboard UI
        if (flipResult == 1){
            facedUp += 1
            chipArray[index]?.texture = SKTexture(imageNamed: "Chip 500x")
        }
        // If Face Down, set Chip faced down on Gameboard UI
        else{
            chipArray[index]?.texture = SKTexture(imageNamed: "Chip Back 500x")
        }
        index += 1
    }
    return facedUp
}


// ----- Adding/Reducing Card/Chips -----

// Adds cards to the player and toggles card display on Gameboard UI
func addCards(thePlayer: Player, cardArray: [SKSpriteNode?], addAmt: Int){
    if (addAmt == 0){
        return
    }
    for _ in 1...addAmt{
        // currentCard = cardAmt; Use that as index to grab card node and toggle display on Gameboard UI
        cardArray[thePlayer.cardAmt]?.isHidden = false
        // Checks for card over-gain (prevents index out of bounds)
        if (thePlayer.cardAmt + 1) == 8{
            thePlayer.cardAmt += 1
            return
        }
        // Increment cardAmt
        thePlayer.cardAmt += 1
    }
}

// Removes cards from the player and toggles card display on Gameboard UI
func removeCards(thePlayer: Player, cardArray: [SKSpriteNode?], removeAmount: Int){
    for _ in 1...removeAmount{
        // Decrement cardAmt
        thePlayer.cardAmt -= 1
        // currentCard = cardAmt; Use that as index to grab card node and toggle display on Gameboard UI
        cardArray[thePlayer.cardAmt]?.isHidden = true
    }
}

// Adds chips to the player and removes them from the graveyard; toggles UI
func addChips(thePlayer: Player, chipArray: [SKSpriteNode?], addAmt: Int){
    if (addAmt == 0){
        return
    }
    for _ in 1...addAmt{
        thePlayer.graveYrdAmt -= 1
        thePlayer.chipAmt += 1
        chipArray[7-thePlayer.chipAmt]?.texture = SKTexture(imageNamed: "Chip 500x")
    }
}

// Removes chips from the player and transfers them to the graveyard; toggles UI
func reduceChips(thePlayer: Player, chipArray: [SKSpriteNode?], reduceAmt: Int){
    if (reduceAmt == 0){
        return
    }
    for _ in 1...reduceAmt{
        chipArray[7-thePlayer.chipAmt]?.texture = SKTexture(imageNamed: "Grey Chip 500x")
        thePlayer.chipAmt -= 1
        thePlayer.graveYrdAmt += 1
    }
}


// ----- Gameboard UI Modifiers -----

// Update health bar on Gameboard UI
func updateHealthBar(thePlayer: Player, healthBar: SKSpriteNode?){
    if(thePlayer.chipAmt == 7){
        healthBar?.texture = SKTexture(imageNamed: "New Health Bar 7")
    }
    else if(thePlayer.chipAmt == 6){
        healthBar?.texture = SKTexture(imageNamed: "New Health Bar 6")
    }
    else if(thePlayer.chipAmt == 5){
        healthBar?.texture = SKTexture(imageNamed: "New Health Bar 5")
    }
    else if(thePlayer.chipAmt == 4){
        healthBar?.texture = SKTexture(imageNamed: "New Health Bar 4")
    }
    else if(thePlayer.chipAmt == 3){
        healthBar?.texture = SKTexture(imageNamed: "New Health Bar 3")
    }
    else if(thePlayer.chipAmt == 2){
        healthBar?.texture = SKTexture(imageNamed: "New Health Bar 2")
    }
    else if(thePlayer.chipAmt == 1){
        healthBar?.texture = SKTexture(imageNamed: "New Health Bar 1")
    }
    else if(thePlayer.chipAmt == 0){
        healthBar?.texture = SKTexture(imageNamed: "New Health Bar 0")
    }
}

// Modify d4 texture on Gameboard UI
func setD4Texture(roll: Int, d4: SKSpriteNode?){
    if (roll == 1){
        d4?.texture = SKTexture(imageNamed: "D4-1")
    }
    else if (roll == 2){
        d4?.texture = SKTexture(imageNamed: "D4-2")
    }
    else if (roll == 3){
        d4?.texture = SKTexture(imageNamed: "D4-3")
    }
    else if (roll == 4){
        d4?.texture = SKTexture(imageNamed: "D4-4")
    }
}

// Update power use label
func updatePwrUseLabel(powerUse: Int, powerUseLabel: SKLabelNode?){
    // Checks whether the power is the Paladin's Shield
    if (powerUseLabel!.name == "palUse"){
        powerUseLabel!.text = String(powerUse) + "/1"
    }
    else{
        powerUseLabel!.text = String(powerUse) + "/2"
    }
}

// Prompts player for power-up (pop-up on Gameboard UI)
/* Array Index Reference:
    0 = Green Skull
    1 = Red Bandage
    2 = Libra's Scale
    3 = Paladin's Shield
 */
func powerPrompt(dimPanel: SKSpriteNode?, buttonArr: [SKSpriteNode?], useArr: [SKLabelNode?], popButtonArr: [SKSpriteNode?], popUseArr: [SKLabelNode?], promptType: String){
    var i = 0
    var upperLimit = 4
    
    // Paladin's Shield Prompt
    if (promptType == "palPrompt"){
        upperLimit = 3
        // Modify UI to grey out Paladin's Shield
        popButtonArr[3]?.texture = SKTexture(imageNamed: "Grey Paladin's Shield 500x")
        popUseArr[3]?.text = useArr[3]?.text
        // Reveal cancel button
        dimPanel?.childNode(withName: "powerPopUp")?.childNode(withName: "popCancelButton")?.isHidden = false
    }
    
    // Set power textures and uses from Gameboard to pop-up
    for _ in 1...upperLimit{
        popButtonArr[i]?.texture = buttonArr[i]?.texture
        popUseArr[i]?.text = useArr[i]?.text
        i += 1
    }
    // Reveal pop-up
    dimPanel?.isHidden = false
    dimPanel?.childNode(withName: "powerPopUp")?.isHidden = false
    // Function end; touch input in GameScene.swift
}

// -----Trade Prompt-----
func tradePrompt(thePlayer: Player, availableChips: SKLabelNode, tradeCount: inout Int, useArr: [SKLabelNode?], tradeUseArr: [SKLabelNode?], dimPanel: SKSpriteNode?){
    // Limiters to prevent player from over-trading
    if (thePlayer.chipAmt == 3){
        tradeCount = 2
    }
    else if (thePlayer.chipAmt == 2){
        tradeCount = 1
    }
    // Set-up trade prompt
    availableChips.text = "Available Chips: " + String(tradeCount)
    var i = 0
    for _ in 1...4{
        tradeUseArr[i]!.text = useArr[i]!.text
        i += 1
    }
    // Reveal pop-up
    dimPanel?.isHidden = false
    dimPanel?.childNode(withName: "tradeBackground")?.isHidden = false
    // Function end; touch input in GameScene.swift
}

// Update Arrow Textures in Trade Prompt
/* Array Index Reference:
   0 = Green Skull
   1 = Red Bandage
   2 = Libra's Scale
   3 = Paladin's Shield
*/
func updateArrows(arrowUpArr: [SKSpriteNode?], arrowDownArr: [SKSpriteNode?], tradeCount: Int, currGreenNum: Int, currRedNum: Int, currPurpleNum: Int, currBlueNum: Int){
    // Create faded arrow textures and place them in an array
    let fadedGreenUp = SKTexture(imageNamed: "Faded Green Arrow Up")
    let fadedRedUp = SKTexture(imageNamed: "Faded Red Arrow Up")
    let fadedPurpleUp = SKTexture(imageNamed: "Faded Purple Arrow Up")
    let fadedBlueUp = SKTexture(imageNamed: "Faded Blue Arrow Up")
    let fadedArrowUpArr = [fadedGreenUp, fadedRedUp, fadedPurpleUp, fadedBlueUp]
    
    let fadedGreenDown = SKTexture(imageNamed: "Faded Green Arrow Down")
    let fadedRedDown = SKTexture(imageNamed: "Faded Red Arrow Down")
    let fadedPurpleDown = SKTexture(imageNamed: "Faded Purple Arrow Down")
    let fadedBlueDown = SKTexture(imageNamed: "Faded Blue Arrow Down")
    let fadedArrowDownArr = [fadedGreenDown, fadedRedDown, fadedPurpleDown, fadedBlueDown]
    
    // Create regular arrows and place into array
    let regGreenUp = SKTexture(imageNamed: "Green Arrow Up")
    let regRedUp = SKTexture(imageNamed: "Red Arrow Up")
    let regPurpleUp = SKTexture(imageNamed: "Purple Arrow Up")
    let regBlueUp = SKTexture(imageNamed: "Blue Arrow Up")
    let arrowUpTexArr = [regGreenUp, regRedUp, regPurpleUp, regBlueUp]
    
    let regGreenDown = SKTexture(imageNamed: "Green Arrow Down")
    let regRedDown = SKTexture(imageNamed: "Red Arrow Down")
    let regPurpleDown = SKTexture(imageNamed: "Purple Arrow Down")
    let regBlueDown = SKTexture(imageNamed: "Blue Arrow Down")
    let arrowDownTexArr = [regGreenDown, regRedDown, regPurpleDown, regBlueDown]
    
    // Grabs currNums and place them in an array
    let currTradeNumArr = [currGreenNum, currRedNum, currPurpleNum, currBlueNum]
    
    // If 0 chips are available for trade, then fade up arrow
    var i = 0
    for _ in 1...4{
        if (tradeCount == 0){
            arrowUpArr[i]?.texture = fadedArrowUpArr[i]
        }
        else {
            // Set up arrow to non-faded
            arrowUpArr[i]?.texture = arrowUpTexArr[i]
        }
        i += 1
    }
    // If current power use (number between arrows) = 0, then fade down arrow
    var k = 0
    for _ in 1...4{
        if (currTradeNumArr[k] == 0) {
            arrowDownArr[k]?.texture = fadedArrowDownArr[k]
        }
        else{
            // TODO: Set down arrow to non-faded
            arrowDownArr[k]?.texture = arrowDownTexArr[k]
        }
        k += 1
    }
}


// ----- Game Result -----
func checkGameResult(player: Player, resultLabel: SKLabelNode) -> Bool{
    if (player.chipAmt == 0){
        resultLabel.text = "GAME OVER"
        return true
    }
    else if (player.cardAmt == 8){
        resultLabel.text = "VICTORY"
        return true
    }
    else{
        return false
    }
}


// ----- Powers -----

// Updates Gameboard UI for available powers; function called after the end of each turn
// Also checks for trade availablility
func powerCheck(thePlayer: Player, buttonArr: [SKSpriteNode?], tradeButton: SKSpriteNode?){
    // Green Skull
    if (thePlayer.skullUse > 0) && (thePlayer.graveYrdAmt >= 2) && (thePlayer.protectedRolls == 0){
        buttonArr[0]?.texture = SKTexture(imageNamed: "Green Skull 500x")
    }
    else{
        buttonArr[0]?.texture = SKTexture(imageNamed: "Grey Skull 500x")
    }
    // Red Bandage
    if (thePlayer.bandageUse > 0) && (thePlayer.graveYrdAmt >= 2) && (thePlayer.protectedRolls == 0){
        buttonArr[1]?.texture = SKTexture(imageNamed: "Red Bandage 500x")
    }
    else{
        buttonArr[1]?.texture = SKTexture(imageNamed: "Grey Bandage 500x")
    }
    // Libra's Scale
    if (thePlayer.scaleUse > 0) && (thePlayer.protectedRolls == 0){
        buttonArr[2]?.texture = SKTexture(imageNamed: "Libra Scale 500x")
    }
    else{
        buttonArr[2]?.texture = SKTexture(imageNamed: "Grey Libra Scale 500x")
    }
    // Paladin's Shield
    if (thePlayer.palUse > 0) && (thePlayer.graveYrdAmt >= 2) && (thePlayer.protectedRolls == 0) && (thePlayer.bandageUse > 0 || thePlayer.skullUse > 0 || thePlayer.scaleUse > 0){
        buttonArr[3]?.texture = SKTexture(imageNamed: "Paladin's Shield 500x")
    }
    else{
        buttonArr[3]?.texture = SKTexture(imageNamed: "Grey Paladin's Shield 500x")
    }
    // Trade Check
    if ((thePlayer.scaleUse == 0) || (thePlayer.palUse == 0) || (thePlayer.skullUse == 0) || (thePlayer.bandageUse == 0)) && (thePlayer.traded == false) && (thePlayer.chipAmt > 1) && (thePlayer.protectedRolls == 0){
        tradeButton?.texture = SKTexture(imageNamed: "New Trade Button")
    }
    else{
        tradeButton?.texture = SKTexture(imageNamed: "Grey New Trade Button")
    }
}

// Libra's Scale
func libraScale(thePlayer: Player, resultLabel: SKLabelNode, chipArray: [SKSpriteNode?], healthBar: SKSpriteNode?, cardArray: [SKSpriteNode?], scaleUse: SKLabelNode, d4: SKSpriteNode?){
    resultLabel.text = "Using Libra's Scale..."
    thePlayer.scaleUse -= 1
    updatePwrUseLabel(powerUse: thePlayer.scaleUse, powerUseLabel: scaleUse)
    
    // Delayed code execution so first result label gets displayed
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
        // Rolls for amount of chips lost
        let firstRoll = Int.random(in: 1...4)
        resultLabel.text = "First weight is " + String(firstRoll)
        
        // Set d4 texture on Gameboard UI
        setD4Texture(roll: firstRoll, d4: d4)
        // Reveal d4 on Gameboard UI
        d4?.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            resultLabel.text = "-" + String(firstRoll) + " Chips"
            let tempChipAmt =  thePlayer.chipAmt - firstRoll
            // Check for over-reduction of chips
            if (tempChipAmt < 0){
                // Temporary values
                thePlayer.chipAmt = 7
                thePlayer.graveYrdAmt = 0
                // Actual damage
                reduceChips(thePlayer: thePlayer, chipArray: chipArray, reduceAmt: 7)
            }
            else{
                reduceChips(thePlayer: thePlayer, chipArray: chipArray, reduceAmt: firstRoll)
            }
            updateHealthBar(thePlayer: thePlayer, healthBar: healthBar)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                // Rolls for amount of cards gained
                let secondRoll = Int.random(in: 1...4)
                resultLabel.text = "Second weight is " + String(secondRoll)
                
                // Set d4 texture on Gameboard UI
                setD4Texture(roll: secondRoll, d4: d4)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    resultLabel.text = "+" + String(secondRoll) + " Cards"
                    let tempCardAmt = thePlayer.cardAmt + secondRoll
                    // Checks for over-gain of cards
                    if (tempCardAmt > 8){
                        // Temporary values
                        thePlayer.cardAmt = 0
                        // Add actual amount (8)
                        addCards(thePlayer: thePlayer, cardArray: cardArray, addAmt: 8)
                    }
                    else {
                        addCards(thePlayer: thePlayer, cardArray: cardArray, addAmt: secondRoll)
                    }
                    // Re-hide d4
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        d4?.isHidden = true
                    }
                }
            }
        }
    }
}

// Paladin's Shield
func palShield(thePlayer: Player, resultLabel: SKLabelNode, palUse: SKLabelNode, turnsLabel: SKLabelNode, turnsCounter: SKLabelNode){
    resultLabel.text = "Using Paladin's Shield..."
    thePlayer.palUse -= 1
    updatePwrUseLabel(powerUse: thePlayer.palUse, powerUseLabel: palUse)

    let palResult = Int.random(in: 0...1)
    
    // Delayed code execution so first result label gets displayed
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
        if (palResult == 0){
            resultLabel.text = "The Shield has failed!"
        }
        else{
            // Paladin's Shield success
            resultLabel.text = "The Shield guards you!"
            thePlayer.protectedRolls = (8 - thePlayer.cardAmt)
            turnsCounter.text = String(thePlayer.protectedRolls)
            // Display number of protected turns left
            turnsLabel.isHidden = false
            turnsCounter.isHidden = false
        }
    }
}

// Green Skull
func greenSkull(thePlayer: Player, resultLabel: SKLabelNode, chipArray: [SKSpriteNode?], healthBar: SKSpriteNode?, cardArray: [SKSpriteNode?], skullUse: SKLabelNode){
    resultLabel.text = "Using Green Skull..."
    thePlayer.skullUse -= 1
    updatePwrUseLabel(powerUse: thePlayer.skullUse, powerUseLabel: skullUse)
    
    let skullResult = Int.random(in: 0...1)
    
    // Delayed code execution so first result label gets displayed
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
        if (skullResult == 0){
            resultLabel.text = "Skull curses you -" + String(thePlayer.graveYrdAmt) + " Chips"
            let tempChipAmt = thePlayer.chipAmt - thePlayer.graveYrdAmt
            // Checks to see if graveYrdAmt is greater than the Player's chipAmt
            // If over-reduction occurs, set player's chip amount to 0
            if (tempChipAmt < 0){
                // Temporary Values
                thePlayer.chipAmt = 7
                thePlayer.graveYrdAmt = 0
                // Actual damage
                reduceChips(thePlayer: thePlayer, chipArray: chipArray, reduceAmt: 7)
            }
            else{
                reduceChips(thePlayer: thePlayer, chipArray: chipArray, reduceAmt: thePlayer.graveYrdAmt)
            }
        }
        else{
            resultLabel.text = "Skull blesses you +" + String(thePlayer.graveYrdAmt) + " Chips & Cards"
            let cardTempAmt = thePlayer.cardAmt + thePlayer.graveYrdAmt
            // Checks to see if player's card amount is greater than 8 (due to over gain by the skull)
            // If over gain occurs, set player's card amount to the max limit of 8
            if (cardTempAmt > 8){
                // Temporary value
                thePlayer.cardAmt = 0
                // Add actual amount (8)
                addCards(thePlayer: thePlayer, cardArray: cardArray, addAmt: 8)
            }
            else{
                addCards(thePlayer: thePlayer, cardArray: cardArray, addAmt: thePlayer.graveYrdAmt)
            }
            // Full Restore
            // Temporary values
            thePlayer.chipAmt = 0
            thePlayer.graveYrdAmt = 7
            // Actual healing
            addChips(thePlayer: thePlayer, chipArray: chipArray, addAmt: 7)
            updateHealthBar(thePlayer: thePlayer, healthBar: healthBar)
        }
    }
}

// Red Bandage
func redBandage(thePlayer: Player, resultLabel: SKLabelNode, chipArray: [SKSpriteNode?], healthBar: SKSpriteNode?, bandageUse: SKLabelNode, d4: SKSpriteNode?){
    resultLabel.text = "Using Red Bandage..."
    thePlayer.bandageUse -= 1
    updatePwrUseLabel(powerUse: thePlayer.bandageUse, powerUseLabel: bandageUse)
    
    // Delayed code execution so first result label gets displayed
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
        // Rolls for healing amount
        let roll = Int.random(in: 1...4)
        resultLabel.text = "+" + String(roll) + " Chips!"
        // Set d4 texture on Gameboard UI
        setD4Texture(roll: roll, d4: d4)
        // Reveal d4 on Gameboard UI
        d4?.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            let tempChipAmount = thePlayer.chipAmt + roll
            // If over gain occurs, set player's chip amount to max limit of 7
            if (tempChipAmount > 7){
                // Temporary value
                thePlayer.chipAmt = 0
                // Heal actual amount
                addChips(thePlayer: thePlayer, chipArray: chipArray, addAmt: 7)
                updateHealthBar(thePlayer: thePlayer, healthBar: healthBar)
            }
            else {
                addChips(thePlayer: thePlayer, chipArray: chipArray, addAmt: roll)
                updateHealthBar(thePlayer: thePlayer, healthBar: healthBar)
            }
            // Re-hide d4
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                d4?.isHidden = true
            }
        }
    }
}
