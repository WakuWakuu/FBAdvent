extends KinematicBody2D

#Variables
onready var velocity = Vector2(0, -1)
onready var speed = 500
onready var kill = get_node("killTimer")



	
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var collisionInfo = move_and_collide(velocity.normalized() * delta * speed)
	
	#Checks if the sound effect can be played. Prevents looping.

		
	#Starts timer if it is not running. Prevents a timer overload.
	if kill.is_stopped():
		kill.start()
	
#Kills bullet and re-enables the SFX
func _on_killTimer_timeout():
	kill.stop()

	queue_free()


#Called when an object enters the bullet's hitbox. Calls the killTimer function when it detects an enemy.
func _on_hitboxBull_area_entered(area):
	var playerCheck = area.get_parent().get_node("/root/Scene/chars/player")
	if area.name == "hitbox":
		_on_killTimer_timeout()
	if area.is_in_group("Boundary"):
		_on_killTimer_timeout()
		print("worked")
		
