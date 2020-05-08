Project Name: Chip Trade Game (Python Prototype)
Authors: David Cao & Tu Cao

Alpha 2.0 Start Date: March 28, 2020
Current Version: Alpha 2.0
Description: 
Based on an original tabletop game, Chip Trade is a strategic probability game. The objective
of the game is to flip multiple chips and based on the amount that are faced up, you obtain a
card. Collect a certain amount of cards and you win. While playing, you have access to various
power-ups which have some interesting effects. This game of chance is simple on the surface,
but has many intricate mechanics that gives this game its strategic depth.

Note: This game currently a prototype being developed in Python. The final product will be developed in Swift for iOS.

----------------------------------------------------------------------------------

Developer Notes:

[3/23/20]
- Completed core mechanics
- Libra's Scale implemented
- Current code does not have input validation or proper prompt loops (will add later)
- Code does not check if player has the proper amount of power up use.

[3/24/20]
- Implemented all other power-ups
- Add context for actions so the player knows what is going on
- Trade mechanic not implemented, ensure that core mechanics and powers work properly
- Include a Turn counter (Track the number of turns)
- Still no valid input validation, add it!
- Restrict use of other powers during Paladin's Shield
- Bug: Red Bandage can over-heal

Plans for Alpha 2.0
- Ensure that rules of the game are followed in the program.
- Paladin's Shield does not obey Section III, Rule 4 of the official rules.
- Modularize code to allow for better maintenance and efficient development
- Implement Turn tracker
- Implement input validation and proper power up use (player has uses of that power)
- Restrict use of other powers during Paladin's Shield
- Bug fixes (Red Bandage)
- More testing

[3/28/20]
- Input validation implemented
- Implemented checks for sufficient power uses
- Implemented checks for power graveyard condition (2 must be in the graveyard besides Libra's Scale)
- Bug fix: Case for when player has 1 chip left is implemented correctly
- Paladin's Shield now obeys Section III, Rule 4 of the official rules
- Turn tracker implemented
- Bug fix: Red Bandage no longer over-heals

Plans for Alpha 3.0:
- Modulized code
- Implement a menu and allow player to replay the game
- Bug fixes (if any)
- Implement Trade mechanic
- Error handling?
- More testing



Version Alpha 2.0 completed on March 28, 2020
