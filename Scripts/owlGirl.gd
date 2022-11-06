extends KinematicBody2D

onready var apple = load("res://Scenes/apple.tscn")
var dead = false
var melee = false
var immunity = true
onready var immunityTimer = int($Immunity.wait_time)

#Health is stored in a timer to allow for easy configuration in form scenes
var health = 5

var phase = 1

var canEmit = false

signal phase1End
signal phase2End
signal phase3End
signal phase4End

func _process(delta):
	if immunity == false:
		BHPatternManager.deregister_other_collider($bulletPhaseClear)

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
					
					phaseChange()
					yield(get_tree().create_timer(1.5), "timeout")
					emit_signal("phase1End")
					
					
				if health <= 0 and phase == 2:

					phaseChange()
					yield(get_tree().create_timer(1.5), "timeout")
					emit_signal("phase2End")
					
					
				if health <= 0 and phase == 3:

					phaseChange()
					yield(get_tree().create_timer(1.5), "timeout")
					emit_signal("phase3End")
					
					
				if health <= 0 and phase == 4:

					phaseChange()
					yield(get_tree().create_timer(1.5), "timeout")
					emit_signal("phase4End")
					
					
func phaseChange():
	BHPatternManager.register_other_collider($bulletPhaseClear)
	$sfx.play()
	immunity = true
	$spellChange.emitting = true
	yield(get_tree().create_timer(1.5), "timeout")
	immunity = false
	phase += 1
	health = int($Health.wait_time)
	
func giveHealth():
	return health

#func _on_changeTimer_timeout():
	#pass # Replace with function body.
