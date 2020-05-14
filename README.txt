Project Name: Chip Trade Game (Python Prototype)
Authors: David Cao & Tu Cao

Alpha 3.0 Start Date: May 12, 2020
Current Version: Alpha 3.0
Description: 
Based on an original tabletop game, Chip Trade is a strategic probability game. The objective
of the game is to flip multiple chips and based on the amount that are faced up, you obtain a
card. Collect a certain amount of cards and you win. While playing, you have access to various
power-ups which have some interesting effects. This game of chance is simple on the surface,
but has many intricate mechanics that gives this game its strategic depth.

Note: This game currently a prototype being developed in Python. The final product will be developed in Swift for iOS.

----------------------------------------------------------------------------------

Developer Notes:

[5/12/20]
- Added roll_chips function.
- Added action_prompt function.
- Modularized all power ups (created functions for them).
- Changed chip and card amount display in player stats to fractions.
- Bug Fix: Green Skull can no longer cause player to gain more than the card limit (8) and causes infinite game.
- Bug Fix: Red Bandage no longer displays "injuries" with 0 chips faced down when failed.

[5/13/20]
- Bug Fix: Player can longer use Paladin's Shield when no other power is in stock.
- Added a main menu.

[5/14/20]
- Implemented trade mechanic.

Plans for Alpha 4.0
- Modularize code?
- Bug fixes (if any)
- More testing



Version Alpha 3.0 completed on May 14, 2020
