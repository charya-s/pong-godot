# Pong
<p>The classic game Pong created on Godot using GDScript.</p>
<p>Created by Charya M. Sendanayake.</p>

## Introduction.
This game was created on the open-source Godot game engine, using GDScript for the logic. It is a simple game of Pong, with some custom Enemy AI mechanics and difficulty levels that modify enemy behaviour. 


## Main Features.
<p>
  The main features of this game include;
</p>

- A difficulty selection before the game starts (affects enemy behaviour as detailed above).
- Main menu with options for volume, fullscreen, etc.
- Skins for player and enemy paddle as well as the ball.
- Multiple stages, with features such as obstacle, boosts, etc.

  
## Enemy AI and Behaviour.
<p>
  One interesting aspect in this implementation of Pong is implemented is in the enemy behaviour.
</p>

- The enemy moves by constantly checking where the ball is and moving to intercept it.
    - The movement speed is dependent on the game level.
    - The movement speed is higher at higher levels. 
- The enemy only starts moving when the ball has traveled a certain distance towards it since being hit by the player.
    - This is called the "activation zone" and the position of this zone is dependent on the game level.
    - The zone is closer to the player in higher levels.
- The enemy stops moving after it successfully hits the ball until the ball is returned by the player and the activation zone is passed again.

<p>
  This results in enemy behaviour that is dependent on game level. A harder enemy (higher level), reacts to the ball sooner and moves faster to intercept the ball, resulting in a higher success rates of hitting the ball and returning it to the player.
</p>


