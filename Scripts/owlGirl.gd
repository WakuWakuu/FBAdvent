extends KinematicBody2D

onready var apple = load("res://Scenes/apple.tscn")
var dead = false
var melee = false
var immunity = true
onready var immunityTimer = int($Immunity.wait_time)

#Health is stored in a timer to allow for easy configuration in form scenes
var health = 5

var phase = 1

signal phase1End
signal phase2End
signal phase3End
signal phase4End

func _ready():
	yield(get_tree().create_timer(0.5), "timeout")
	
	health = int($Health.wait_time)
	
	yield(get_tree().create_timer(immunityTimer), "timeout")
	
	immunity = false
	
#Called when something enters the owl's hitbox
func _on_hitbox_area_entered(area):
		
		if immunity == false:
			#Checks if the hitbox is a bullet
			if area.name == "hitboxBull":
				health -= 1
				#print(int($Health.wait_time))
				#print(health)
				
				if health <= 0 and phase == 1:

					#$sfx.play()
					yield(get_tree().create_timer(0.1), "timeout")
					phase += 1
					emit_signal("phase1End")
					health = int($Health.wait_time)
					$spellChange.emitting = true
					$spellChange.emitting = false
					
				if health <= 0 and phase == 2:

					#$sfx.play()
					yield(get_tree().create_timer(0.1), "timeout")
					phase += 1
					emit_signal("phase2End")
					health = int($Health.wait_time)
					$spellChange.emitting = true
					$spellChange.emitting = false
					
				if health <= 0 and phase == 3:

					#$sfx.play()
					yield(get_tree().create_timer(0.1), "timeout")
					phase += 1
					emit_signal("phase3End")
					health = int($Health.wait_time)
					$spellChange.emitting = true
					$spellChange.emitting = false
					
				if health <= 0 and phase == 4:

					#$sfx.play()
					yield(get_tree().create_timer(0.1), "timeout")
					phase += 1
					emit_signal("phase4End")
					health = int($Health.wait_time)
					$spellChange.emitting = true
					$spellChange.emitting = false
					
					
