# Work in progress...
def display_intro():
    # TODO
    pass


def play_game():
    # TODO
    pass


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

# Other functions will be added later...
