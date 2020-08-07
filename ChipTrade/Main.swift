//
//  Main.swift
//  ChipTradeSpriteKitVer
//
//  Created by David Cao on 7/14/20.
//  Copyright © 2020 David Cao. All rights reserved.
//

import Foundation

func playGame() {
    while true {
        // Title / Intro
        // displayIntro()

        // Main Menu
        // displayMenu()
        print("Selection: ")
        let menu_selection = readLine()!

        if (menu_selection == "2"){
            exit(0)
        }

        print("\n|GAME START|\n")

        // Initialize player
        let thePlayer = Player()

        // Turn tracker
        var turnCount = 1

        // Play game while player's chip amount is not 0 and card amount is not 8.
        while (thePlayer.chipAmt > 0) && (thePlayer.cardAmt != 8){
            print("\n~[Turn", String(turnCount) + "]~")

            // Display current stats (Player)
            // displayStats(player: thePlayer)

            // Prompt player for action
            let action = "1" // actionPrompt(thePlayer: thePlayer)

            // Action Cases:

            // Roll Action (Basic Mechanic)
            if (action == "1"){
                // Rolls chips (returns the amount faced up)
                let facedUp = 4 // <---- Originally rollChips()
                // All 7 faced up or down case:
                if(facedUp == 7) || ((facedUp == 0) && (thePlayer.chipAmt == 7)){
                    print("Lucky 7!")
                    thePlayer.cardAmt += 3
                }
                // All 6 or less chips faced up case:
                else if (facedUp == thePlayer.chipAmt) && (thePlayer.protectedRolls == 0) && (thePlayer.chipAmt != 1){
                    print("All chips faced up! +1 Card and +1 Power-Up of your choice!")
                    thePlayer.cardAmt += 1
                    print("Select a Power-Up that you want:")
                    print("1.) Libra's Scale\t2.) Paladin's Shield\t3.)Green Skull\t4.) Red Bandage")
                    print("Enter selection: ")
                    let desPwr = readLine()!
                    if (desPwr == "1"){
                        thePlayer.scaleUse += 1
                    }
                    else if (desPwr == "2"){
                        thePlayer.palUse += 1
                    }
                    else if (desPwr == "3"){
                        thePlayer.skullUse += 1
                    }
                    else if (desPwr == "4"){
                        thePlayer.bandageUse += 1
                    }
                }
                // All 6 or less chips faced down case:
                else if (facedUp == 0) && (thePlayer.protectedRolls == 0) && (thePlayer.chipAmt != 1){
                    print("All chips faced down! +1 Chip")
                    thePlayer.graveYrdAmt -= 1
                    thePlayer.chipAmt += 1
                }
                // Even faced up case:
                else if(facedUp % 2) == 0{
                    // Checks if the Chip Amount the player has is 1
                    if (thePlayer.chipAmt != 1){
                        print("Roll was EVEN! +1 Card")
                        thePlayer.cardAmt += 1
                    }
                    else{
                        print("Saved from death! +1 Chip")
                        thePlayer.graveYrdAmt -= 1
                        thePlayer.chipAmt += 1
                    }
                }
                // Odd faced up case:
                else{
                    print("Roll was ODD!")
                    if (thePlayer.protectedRolls == 0){
                        print("-1 Chip")
                        thePlayer.chipAmt -= 1
                        thePlayer.graveYrdAmt += 1
                        if (thePlayer.cardAmt > 0){
                            print("-1 Card")
                            thePlayer.cardAmt -= 1
                        }
                    }
                    else{
                        print("The Paladin's Shield protects you...")
                    }
                }
                // Checks to see if Paladin's Shield is active; reduce protectedRolls if so
                if (thePlayer.protectedRolls > 0){
                    thePlayer.protectedRolls -= 1
                    if (thePlayer.protectedRolls == 0){
                        print("The Paladin's Shield no longer guards you...")
                    }
                }
                print()
                // End of turn
                turnCount += 1
            }

            // Libra's Scale
            else if (action == "2") && (thePlayer.scaleUse > 0) && (thePlayer.protectedRolls == 0){
                // libraScale(thePlayer: thePlayer)
                turnCount += 1
            }

            // Paladin's Shield
            else if (action == "3") && (thePlayer.palUse > 0) && (thePlayer.graveYrdAmt >= 2) && (thePlayer.protectedRolls == 0) && (thePlayer.bandageUse > 0 || thePlayer.skullUse > 0 || thePlayer.scaleUse > 0){
                // palShield(thePlayer: thePlayer)
                turnCount += 1
            }

            // Green Skull
            else if (action == "4") && (thePlayer.skullUse > 0) && (thePlayer.graveYrdAmt >= 2) && (thePlayer.protectedRolls == 0){
                // greenSkull(thePlayer: thePlayer)
                turnCount += 1
            }

            // Red Bandage
            else if (action == "5") && (thePlayer.bandageUse > 0) && (thePlayer.graveYrdAmt >= 2) && (thePlayer.protectedRolls == 0){
                // redBandage(thePlayer: thePlayer)
                turnCount += 1
            }

            // Trade
            else if (action == "0") && (thePlayer.scaleUse == 0 || thePlayer.palUse == 0 || thePlayer.skullUse == 0 || thePlayer.bandageUse == 0) && (thePlayer.traded == false){
                trade(player: thePlayer)
                // Only counts as a Turn if player trades
                if (thePlayer.traded == true){
                    turnCount += 1
                }
            }

            // Invalid Action
            else{
                print("Invalid selection...\n")
                // When player attempts to use another power during Paladin's Shield
                palActiveMsg(action: action, player: thePlayer)
                // When player attempts to use Paladin's Shield when no other power is in stock for sacrifice
                noPwrStockForPalMsg(action: action, player: thePlayer)
                // When player has already traded of attempts to trade with no powers having 0 usage
                invalidTradeMsg(action: action, player: thePlayer)
            }
        }

        // Display Game Result
        // displayGameResult(player: thePlayer)
        print("\nPress Enter to return to main menu...")
        var _ = readLine()!
        print("\n")
    }
}

