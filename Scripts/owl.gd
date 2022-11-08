extends KinematicBody2D

onready var apple = load("res://Scenes/apple.tscn")
onready var power = load("res://Scenes/powerup.tscn")
var dead = false
var melee = false
var immunity = true
var big = false
onready var immunityTimer = int($Immunity.wait_time)

#Health is stored in a timer to allow for easy configuration in form scenes
var health = 1

signal powerIncrease


func _ready():
	
	yield(get_tree().create_timer(0.5), "timeout")
	health = int($Health.wait_time)
	if $Health.wait_time >= 5:
		big = true
		scale = Vector2(1.5,1.5)
	yield(get_tree().create_timer(immunityTimer), "timeout")
	immunity = false
#Called when something enters the owl's hitbox
func _on_hitbox_area_entered(area):
		
		if immunity == false:
			#Checks if the hitbox is a bullet
			if area.name == "hitboxBull" and dead == false:
				health -= 1
				#print(int($Health.wait_time))
				#print(health)
				
				if health <= 0 and big == false:
					#Spawns apple
					var spawnApple = apple.instance()
					get_parent().get_parent().add_child(spawnApple)
					spawnApple.global_position = $Position2D.global_position
					$sfx.play()
					dead = true
					yield(get_tree().create_timer(0.1), "timeout")
					if melee == true:
						print("in melee range")
						emit_signal("powerIncrease")
					else:
						pass
					#Kills the owl add
					#queue_free()
					call_deferred("free")
					
				if health <= 0 and big == true:
					#Spawns apple
					var spawnPower = power.instance()
					get_parent().get_parent().add_child(spawnPower)
					spawnPower.global_position = $Position2D.global_position
					$sfx.play()
					dead = true
					yield(get_tree().create_timer(0.1), "timeout")
					if melee == true:
						print("in melee range")
						emit_signal("powerIncrease")
					else:
						pass
					#Kills the owl add
					#queue_free()
					call_deferred("free")
				
			#note to self, add powerup drop to enemies if their health is 

#Movements are controlled by AnimationPlayers, so there is no code here for that.
#Attacks are controlled by the enemy form scripts.


func _on_meleeRange_area_entered(area):
	if area.name == "meleeArea":
		melee = true


func _on_meleeRange_area_exited(area):
	if area.name == "meleeArea":
		melee = false


