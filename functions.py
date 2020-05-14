import random


# Displays the intro message
def display_intro():
    print("----------Chip Trade----------")
    print("Version: Alpha 3.0")
    print("Rules are included in separate document\n")


# Display main menu
def display_menu():
    print("1.) Start Game\n2.) Quit\n")


# Display current player stats (chips, graveyard, etc.)
def display_stats(player):
    print("-----Player Stats-----")
    print("Chips:", str(player.chip_amt) + "/7")
    print("Cards:", str(player.card_amt) + "/8")
    print("Graveyard Chips:", player.grave_yrd_amt)
    if player.protected_rolls > 0:
        print("Protected Rolls Remaining:", player.protected_rolls)
    print()
    print("-----Power Up Uses-----")
    print("Libra's Scale:", player.scale_use)
    print("Paladin's Shield:", player.pal_use)
    print("Green Skull:", player.skull_use)
    print("Red Bandage:", player.bandage_use)
    print()


# Basic roll mechanic
def roll_chips(thePlayer):
    print("\n-----Roll Result-----")
    faced_up = 0
    for chip in range(thePlayer.chip_amt):
        # Flip a chip
        flip_result = random.randint(0, 1)
        # 0 = Face Down; 1 = Face Up
        if flip_result == 1:
            faced_up += 1
    print(faced_up, "faced up!")
    return faced_up


# Prompt player for action
def action_prompt(thePlayer):
    print("Select an action: ")
    if thePlayer.protected_rolls > 0:
        # If Paladin's Shield is active, the player can only roll
        action = input("1.) Roll\nSelection: ")
    elif thePlayer.grave_yrd_amt < 2:
        action = input("1.) Roll\t2.) Libra's Scale\t0.) Trade\nSelection: ")
    else:
        print("1.) Roll\t2.) Libra's Scale\t3.) Paladin's Shield\t4.)Green Skull\t5.) Red Bandage\t0.) Trade")
        action = input("Selection: ")

    return action


# -----Invalid Action Messages-----

# When player attempts to use a power that has no uses left
def insufficient_pwr_msg(action, player):
    if (action == "2") and (player.scale_use == 0):
        print("You have no uses of Libra's Scale left!")
    elif (action == "3") and (player.pal_use == 0):
        print("You have no uses of Paladin's Shield left!")
    elif (action == "4") and (player.skull_use == 0):
        print("You have no uses of Green Skull left!")
    elif (action == "5") and (player.bandage_use == 0):
        print("You have no uses of Red Bandage left!")


# When player attempts to use another power during Paladin's Shield
def pal_active_msg(action, player):
    if (action != "1") and (player.protected_rolls > 0):
        print("Paladin's Shield is active! You cannot use another power-up!")


# When player attempts to use Paladin's Shield when no other power is in stock for sacrifice
def no_pwr_stock_for_pal_msg(action, player):
    if (action == "3") and (player.pal_use > 0) and (player.bandage_use == 0 or
                                                     player.skull_use == 0 or player.scale_use == 0):
        print("No other power-ups are in stock for Paladin's Shield sacrifice!")


# When player has already traded of attempts to trade with no powers having 0 usage
def invalid_trade_msg(action, player):
    if (action == "0") and (player.traded is True):
        print("Cannot trade again!")
    else:
        print("At least one power-up must be gone for a trade!")


# -----Game Result-----
def display_game_result(player):
    display_stats(player)
    if player.card_amt == 8:
        print("-----VICTORY-----")
    else:
        print("-----DEFEAT-----")


# -----Powers-----

# Libra's Scale
def libra_scale(thePlayer):
    print("\n-----Power Result-----")
    if thePlayer.scale_use > 0:
        thePlayer.scale_use -= 1
        # Rolls for amount of chips lost
        first_roll = random.randint(1, 4)
        print("The first weight is", first_roll, "\n-" + str(first_roll), "Chips")
        thePlayer.chip_amt -= first_roll
        thePlayer.grave_yrd_amt += first_roll
        # Rolls for amount of cards gained
        second_roll = random.randint(1, 4)
        print("The second weight is", second_roll, "\n+" + str(second_roll), "Cards")
        thePlayer.card_amt += second_roll
    print()


# Paladin's Shield
def pal_shield(thePlayer):
    thePlayer.pal_use -= 1
    print("What power would you like to give up (1 use):")
    print("1.) Libra's Scale\t2.) Green Skull\t3.) Red Bandage")
    pwr_give_up = input("Selection: ")
    print("\n-----Power Result-----")
    if pwr_give_up == "1":
        thePlayer.scale_use -= 1
    elif pwr_give_up == "2":
        thePlayer.skull_use -= 1
    elif pwr_give_up == "3":
        thePlayer.bandage_use -= 1

    pal_result = random.randint(0, 1)
    if pal_result == 0:
        print("The Paladin's Shield has failed!")
    else:
        # Paladin's Shield success
        print("The Paladin's Shield guards you!")
        thePlayer.protected_rolls = (8 - thePlayer.card_amt)
    print()


# Green Skull
def green_skull(thePlayer):
    print("\n-----Power Result-----")
    thePlayer.skull_use -= 1
    skull_result = random.randint(0, 1)
    if skull_result == 0:
        print("The skull curses you... -" + str(thePlayer.grave_yrd_amt), "Chips")
        thePlayer.chip_amt -= thePlayer.grave_yrd_amt
        thePlayer.grave_yrd_amt *= 2
    else:
        print("The skull blesses you... +" + str(thePlayer.grave_yrd_amt), "Chips and Cards")
        thePlayer.card_amt += thePlayer.grave_yrd_amt
        # Checks to see if player's card amount is greater than 8 (due to over gain by the skull)
        # Fix: Sets player's card amount to the max limit of 8 if over gain occurs
        if thePlayer.card_amt > 8:
            thePlayer.card_amt = 8
        thePlayer.chip_amt = 7
        thePlayer.grave_yrd_amt = 0
    print()


def red_bandage(thePlayer):
    print("\n-----Power Result-----")
    thePlayer.bandage_use -= 1
    bandage_result = random.randint(0, 1)
    if bandage_result == 0:
        print("The Bandage has failed!")
        faced_down = 0
        for chip in range(thePlayer.chip_amt):
            # Flip a chip
            flip_result = random.randint(0, 1)
            # 0 = Face Down; 1 = Face Up
            if flip_result == 0:
                faced_down += 1
        # Lucky case where bandage fails, but ZERO chips are FACED DOWN in roll (player loses no chips)
        if faced_down == 0:
            print("Your carefulness leaves you unscathed!")
            print("You avoided any damage... -" + str(faced_down), "Chips")
        else:
            print("You have sustained injuries... -" + str(faced_down), "Chips")
        thePlayer.chip_amt -= faced_down
        thePlayer.grave_yrd_amt += faced_down
    else:
        print("The bandage heals you!")
        faced_up = 0
        for chip in range(thePlayer.chip_amt):
            # Flip a chip
            flip_result = random.randint(0, 1)
            # 0 = Face Down; 1 = Face Up
            if flip_result == 1:
                faced_up += 1
        # Calculates the final amount of chips the player will have after recovery
        total_chips = thePlayer.chip_amt + faced_up
        # If it results in an over-heal (or full-heal), fully restores player to max of 7 chips
        if total_chips >= 7:
            print("You have fully recovered!")
            thePlayer.chip_amt = 7
            thePlayer.grave_yrd_amt = 0
        # Unlucky case where the bandage succeeds, but ZERO chips are FACED UP in the roll...
        elif faced_up == 0:
            print("The bandage's power was too weak!")
            print("You have recovered! +" + str(faced_up), "Chips")
        # If not an over-heal/full-heal, normal rule applies
        else:
            print("You have recovered! +" + str(faced_up), "Chips")
            thePlayer.chip_amt = total_chips
            thePlayer.grave_yrd_amt -= faced_up
        print("You have been rewarded! +" + str(faced_up), "Cards")
        thePlayer.card_amt += faced_up
    print()


# -----Trading Mechanic-----
def trade(player):
    # Keeps track of the amount of trades
    trade_count = 3
    # Limits trades to a max of 3 and ensures player has enough chips to trade
    while trade_count > 0 and player.chip_amt > 1:
        display_stats(player)
        print("\n-----Trading-----")
        print("Trades available:", trade_count)
        print("Select a desired power. To end trading, enter 'q'")
        print("1.) Libra's Scale\t2.) Paladin's Shield\t3.)Green Skull\t4.) Red Bandage")
        selection = input("Selection: ")

        # Libra's Scale
        if selection == "1":
            player.scale_use += 1
            player.chip_amt -= 1
            player.grave_yrd_amt += 1
            print("+1 Libra's Scale")
            print("-1 Chip")
            trade_count -= 1
        # Paladin's Shield
        elif selection == "2":
            player.pal_use += 1
            player.chip_amt -= 1
            player.grave_yrd_amt += 1
            print("+1 Paladin's Shield")
            print("-1 Chip")
            trade_count -= 1
        # Green Skull
        elif selection == "3":
            player.skull_use += 1
            player.chip_amt -= 1
            player.grave_yrd_amt += 1
            print("+1 Green Skull")
            print("-1 Chip")
            trade_count -= 1
        # Red Bandage
        elif selection == "4":
            player.bandage_use += 1
            player.chip_amt -= 1
            player.grave_yrd_amt += 1
            print("+1 Red Bandage")
            print("-1 Chip")
            trade_count -= 1
        # Exit trade
        elif selection == "q" or "Q":
            break
        else:
            print("Invalid selection...")

    # Player exits trade without trading anything
    if (selection == "q" or "Q") and (trade_count == 3):
        return
    else:
        player.traded = True
