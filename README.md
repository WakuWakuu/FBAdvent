# Fruit Bat Adventure
Fruit Bat Adventure, a cute bullet hell shoot-em-up written in Godot. This project was made as part of a private hackathon/game jam.

Made with help of the GodotBulletHellper plugin, which can be found here: https://github.com/mavsm/GodotBulletHellper 

This game runs a slightly modified version of said plugin, which is included in the files here.

Dialogic is used for the dialogue. It is also included here, but the plugin can be found here: https://github.com/coppolaemilio/dialogic 

Godot engine can also be found here: https://github.com/godotengine/godot


Sprites, animations, artwork, music, and sfx are all made by me.
All the programming (with the exception of Godot and BulletHellper) was also done by me, using Godot's docs and forums as references.
None of Dialogic's default GUI assets are used.

This is my first real project, so the code may be messy and inefficient. There are a lot of inconsistencies with variable usage, which should hopefully be fixed in the final release. Comments will be added later on. 

Edit: Code will remain commentless, as there isn't enough time for me comment everything now.

# The game
Fruit bat girl is enjoying the lovely sunny day when she finds out that all her apples were stolen. Being hungry, she sets off to find her apples and comes across a horde of owls led by Owl girl. Help Fruit bat girl get all her apples back in this difficult bullet hell shoot-em-up! Currently there are two stages available, with the second one having unfinished music and sprites.


# Controls

Shoot: Z

Focus (slow down): Shift

Move: Arrow keys

Skill: X

Debug mode (infinite lives): Spacebar

Power can be obtained by killing enemies within the apple collection zone that appears when focusing. When the power gauge is filled, all bullets on the screen will be cleared.

# Source code
This game was coded with modularity in mind, and as such, this game utilizes Godot's scene system for many things in the game. Stages are contained within their own scenes, which are loaded into the main in-game scene. Stage enemies are organized into "enemy forms", which are scenes that contain movement and attack data. Movement is controlled using Godot's AnimationPlayer rather than the enemy form scripts. Enemies don't have much in their scripts, as it's the enemy form scripts that are controlling their attacks. The bosses work in a similar way, only now with phases implemented. Once a stage is done, the game deletes the current stage and replaces with the scene of the next stage. 

All the bullet patterns here were created using BulletHellper's visual editor, with certain attacks like "The Grass Dance" being modified within the enemy form scripts, as the visual editor can only do so much.
