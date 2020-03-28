# Work in progress...


# Displays the intro message
def display_intro():
    print("----------Chip Trade----------")
    print("Version: Alpha 2.0")
    print("Rules are included in separate document\n")


# Display current player stats (chips, graveyard, etc.)
def display_stats(player):
    print("-----Player Stats-----")
    print("Chips:", player.chip_amt)
    print("Cards:", player.card_amt)
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


def roll_chips():
    # TODO
    pass


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
    else:
        pass


# When player attempts to use another power during Paladin's Shield
def pal_active_msg(action, player):
    if (action != "1") and (player.protected_rolls > 0):
        print("Paladin's Shield is active! You cannot use another power-up!")
    else:
        pass


def display_game_result(player):
    display_stats(player)
    if player.card_amt == 8:
        print("-----VICTORY-----")
    else:
        print("-----DEFEAT-----")


# Other functions will be added later...
