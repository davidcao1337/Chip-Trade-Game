from classes import Player
import functions


while True:
    # Title / Intro
    functions.display_intro()

    # Main Menu
    functions.display_menu()
    menu_selection = input("Selection: ")

    if menu_selection == "2":
        exit(0)

    print("\n|GAME START|\n")

    # Initialize player
    thePlayer = Player()

    # Turn tracker
    turn_count = 1

    # Play game while player's chip amount is not 0 and card amount is not 8.
    while (thePlayer.chip_amt > 0) and (thePlayer.card_amt != 8):
        print("\n~[Turn", str(turn_count) + "]~")

        # Display current stats (Player)
        functions.display_stats(thePlayer)

        # Prompt player for action
        action = functions.action_prompt(thePlayer)

        # Action Cases:

        # Roll Action (Basic Mechanic)
        if action == "1":
            # Rolls chips (returns the amount faced up)
            faced_up = functions.roll_chips(thePlayer)
            # All 7 faced up or down case:
            if(faced_up == 7) or ((faced_up == 0) and (thePlayer.chip_amt == 7)):
                print("Lucky 7!")
                thePlayer.card_amt += 3
            # All 6 or less chips faced up case:
            elif (faced_up == thePlayer.chip_amt) and (thePlayer.protected_rolls == 0) and (thePlayer.chip_amt != 1):
                print("All chips faced up! +1 Card and +1 Power-Up of your choice!")
                thePlayer.card_amt += 1
                print("Select a Power-Up that you want:")
                print("1.) Libra's Scale\t2.) Paladin's Shield\t3.)Green Skull\t4.) Red Bandage")
                desPwr = input("Enter selection: ")
                if desPwr == "1":
                    thePlayer.scale_use += 1
                elif desPwr == "2":
                    thePlayer.pal_use += 1
                elif desPwr == "3":
                    thePlayer.skull_use += 1
                elif desPwr == "4":
                    thePlayer.bandage_use += 1
            # All 6 or less chips faced down case:
            elif (faced_up == 0) and (thePlayer.protected_rolls == 0) and (thePlayer.chip_amt != 1):
                print("All chips faced down! +1 Chip")
                thePlayer.grave_yrd_amt -= 1
                thePlayer.chip_amt += 1
            # Even faced up case:
            elif(faced_up % 2) == 0:
                # Checks if the Chip Amount the player has is 1
                if thePlayer.chip_amt != 1:
                    print("Roll was EVEN! +1 Card")
                    thePlayer.card_amt += 1
                else:
                    print("Saved from death! +1 Chip")
                    thePlayer.grave_yrd_amt -= 1
                    thePlayer.chip_amt += 1
            # Odd faced up case:
            else:
                print("Roll was ODD!")
                if thePlayer.protected_rolls == 0:
                    print("-1 Chip")
                    thePlayer.chip_amt -= 1
                    thePlayer.grave_yrd_amt += 1
                    if thePlayer.card_amt > 0:
                        print("-1 Card")
                        thePlayer.card_amt -= 1
                else:
                    print("The Paladin's Shield protects you...")
            if thePlayer.protected_rolls > 0:
                thePlayer.protected_rolls -= 1
                if thePlayer.protected_rolls == 0:
                    print("The Paladin's Shield no longer guards you...")
            print()
            turn_count += 1

        # Libra's Scale
        elif (action == "2") and (thePlayer.scale_use > 0) and (thePlayer.protected_rolls == 0):
            functions.libra_scale(thePlayer)
            turn_count += 1

        # Paladin's Shield
        elif (action == "3") and (thePlayer.pal_use > 0) and (thePlayer.grave_yrd_amt >= 2) and \
                (thePlayer.protected_rolls == 0) and \
                (thePlayer.bandage_use > 0 or thePlayer.skull_use > 0 or thePlayer.scale_use > 0):
            functions.pal_shield(thePlayer)
            turn_count += 1

        # Green Skull
        elif (action == "4") and (thePlayer.skull_use > 0) and (thePlayer.grave_yrd_amt >= 2) and \
                (thePlayer.protected_rolls == 0):
            functions.green_skull(thePlayer)
            turn_count += 1

        # Red Bandage
        elif (action == "5") and (thePlayer.bandage_use > 0) and (thePlayer.grave_yrd_amt >= 2) and \
                (thePlayer.protected_rolls == 0):
            functions.red_bandage(thePlayer)
            turn_count += 1

        # Trade
        elif (action == "0") and (thePlayer.scale_use == 0 or thePlayer.pal_use == 0 or thePlayer.skull_use == 0 or
                                  thePlayer.bandage_use == 0) and (thePlayer.traded is False):
            functions.trade(thePlayer)
            # Only counts as a Turn if player trades
            if thePlayer.traded is True:
                turn_count += 1

        # Invalid Action
        else:
            print("Invalid selection...\n")
            # When player attempts to use a power that has no uses left
            functions.insufficient_pwr_msg(action, thePlayer)
            # When player attempts to use another power during Paladin's Shield
            functions.pal_active_msg(action, thePlayer)
            # When player attempts to use Paladin's Shield when no other power is in stock for sacrifice
            functions.no_pwr_stock_for_pal_msg(action, thePlayer)
            # When player has already traded of attempts to trade with no powers having 0 usage
            functions.invalid_trade_msg(action, thePlayer)

    # Display Game Result
    functions.display_game_result(thePlayer)
    ret_menu = input("\nPress Enter to return to main menu...")
    print("\n")

