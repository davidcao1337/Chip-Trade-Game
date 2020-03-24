import random
from classes import Player
import functions

# Title / Intro
print("----------Chip Trade----------")
print("Rules are included in separate document\n")

# Initialize player
thePlayer = Player()

# Prompt player for action
while (thePlayer.chip_amt > 0) and (thePlayer.card_amt != 8):
    functions.display_stats(thePlayer)
    print("Select an action: ")
    if thePlayer.grave_yrd_amt < 2:
        action = input("1.) Roll\t2.) Libra's Scale\nSelection:")
    else:
        action = input("1.) Roll\t2.) Libra's Scale\t3.) Paladin's Shield\t4.)Green Skull\t5.) Red Bandage\nSelection:")

    # Action Cases

    # Roll Action (Basic Mechanic)
    if action == "1":
        faced_up = 0
        for chip in range(thePlayer.chip_amt):
            # Flip a chip
            flip_result = random.randint(0, 1)
            # 0 = Face Down; 1 = Face Up
            if flip_result == 1:
                faced_up += 1
        print(faced_up, "are faced up!")

        # All 7 faced up or down case:
        if(faced_up == 7) or ((faced_up == 0) and (thePlayer.chip_amt == 7)):
            print("Lucky 7!")
            thePlayer.card_amt += 3
        # All 6 or less chips faced up case:
        elif faced_up == thePlayer.chip_amt:
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
        elif faced_up == 0:
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

    # Libra's Scale
    elif action == "2":
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
        else:
            print("There's no use of that power left!")
            # Loop action prompt

    # Paladin's Shield
    elif action == "3":
        thePlayer.pal_use -= 1
        print("What power would you like to give up (1 use):")
        print("1.) Libra's Scale\t2.) Green Skull\t3.) Red Bandage")
        pwr_give_up = input("Selection: ")
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

    # Green Skull
    elif action == "4":
        thePlayer.skull_use -= 1
        skull_result = random.randint(0, 1)
        if skull_result == 0:
            print("The skull curses you... -" + str(thePlayer.grave_yrd_amt), "Chips")
            thePlayer.chip_amt -= thePlayer.grave_yrd_amt
            thePlayer.grave_yrd_amt *= 2
        else:
            print("The skull blesses you... +" + str(thePlayer.grave_yrd_amt), "Chips and Cards")
            thePlayer.card_amt += thePlayer.grave_yrd_amt
            thePlayer.chip_amt = 7
            thePlayer.grave_yrd_amt = 0

    # Red Bandage
    elif action == "5":
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
            print("You have recovered! +" + str(faced_up), "Chips")
            thePlayer.chip_amt += faced_up
            thePlayer.grave_yrd_amt -= faced_up
            print("You have been rewarded! +" + str(faced_up), "Cards")
            thePlayer.card_amt += faced_up

functions.display_stats(thePlayer)
if thePlayer.card_amt == 8:
    print("-----VICTORY-----")
else:
    print("-----DEFEAT-----")