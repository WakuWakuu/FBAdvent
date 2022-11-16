extends Node2D


onready var anim = $AnimationPlayer
onready var time = $Start
onready var bullStart = $bull

onready var add1 = load("res://Scenes/patterns/2add3.tscn")
onready var add2 = load("res://Scenes/patterns/2add3_1.tscn")
onready var owl1 = $Owl
onready var owl1Health = $Owl/Health

onready var owl1ref = weakref(owl1)
onready var owl1Pos = $Owl/Position2D

onready var att1 = add1.instance()
onready var att2 = add2.instance()

onready var player = get_tree().get_nodes_in_group("player").front()

var canShoot = false

# Called when the node enters the scene tree for the first time.
func ready():
	if owl1ref.get_ref():
		owl1.ready()
		owl1Health.wait_time = 30
	time.start() #Starts timer
	
#Plays the first stage enemy form
func _on_Start_timeout():
	
	anim.current_animation = "New Anim"
	$Shoot.start()
	
	if owl1ref.get_ref():
		owl1.add_child(att1)
		owl1.add_child(att2)
		#var at1 = att1.get_node("BulletPattern")
		att1.global_position = owl1.global_position
		att2.global_position = owl1.global_position
		#at1.global_position = owl1.global_position
		att1.set_aim_target(player)
		att2.set_aim_target(player)
	
	
	BHPatternManager.register_bullet_container(get_parent())
	

	

#Kills scene after some time
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

#Disable
func _on_bull_timeout():
	if owl1ref.get_ref():
		att1.disable()
		att2.disable()



func _on_Shoot_timeout():
	if owl1ref.get_ref():
		att1.global_position = owl1.global_position
		att2.global_position = owl1.global_position

		att1.set_aim_target(player)
		att1.enable()
		att2.enable()
		
	bullStart.start()
