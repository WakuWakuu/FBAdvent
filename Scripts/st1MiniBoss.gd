extends Node2D


onready var anim = $AnimationPlayer
onready var time = $Start
onready var bullStart = $bull

onready var add1 = load("res://Scenes/patterns/add2.tscn")
onready var owl1 = $Owl
onready var owl2 = $Owl2
onready var owl1ref = weakref(owl1)
onready var owl2ref = weakref(owl2)
onready var owl1Pos = $Owl/Position2D
onready var owl2Pos = $Owl2/Position2D

onready var att1 = add1.instance()
onready var att2 = add1.instance()

onready var player = get_tree().get_nodes_in_group("player").front()

var canShoot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	time.start() #Starts timer
	
#Plays the first stage enemy form
func _on_Start_timeout():
	anim.current_animation = "New Anim"
	
	if owl1ref.get_ref():
		owl1.add_child(att1)
		#var at1 = att1.get_node("BulletPattern")
		att1.global_position = owl1.global_position
		#at1.global_position = owl1.global_position
		att1.set_aim_target(player)
	
	if owl2ref.get_ref():
		owl2.add_child(att2)
		#var at2 = att2.get_node("BulletPattern")
		att2.global_position = owl2.global_position
		#at2.global_position = owl2.global_position
		att2.set_aim_target(player)
	
	BHPatternManager.register_bullet_container(get_parent())
	
	canShoot = true
	
	if canShoot == true:

		if owl1ref.get_ref():
			att1.global_position = owl1.global_position
			#at1.global_position = owl1.global_position
			att1.set_aim_target(player)
			att1.enable()
			
		if owl2ref.get_ref():	
			att2.global_position = owl2.global_position
			#at2.global_position = owl2.global_position
			att2.set_aim_target(player)
			att2.enable()
		
		
		bullStart.start()
	

#Kills scene after some time
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

#Disable
func _on_bull_timeout():
	if owl1ref.get_ref():
		att1.disable()
	if owl2ref.get_ref():
		att2.disable()
