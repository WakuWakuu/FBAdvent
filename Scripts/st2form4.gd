extends Node2D


onready var anim = $AnimationPlayer
onready var time = $Start
onready var bullStart = $bull

onready var add1 = load("res://Scenes/patterns/add11.tscn")
onready var add2 = load("res://Scenes/patterns/2add2.tscn")
onready var add3 = load("res://Scenes/patterns/2add1.tscn")
onready var add1Instanced = add1.instance()
onready var add2Instanced = add2.instance()
onready var add3Instanced = add3.instance()
onready var owl1 = $Owl2
onready var owl2 = $Owl
onready var owl1Health = $Owl2/Health
onready var owl2Health = $Owl/Health
onready var owl1ref = weakref(owl1)
onready var owl2ref = weakref(owl2)
onready var owl1Pos = $Owl2/Position2D
onready var owl2Pos = $Owl/Position2D

onready var player = get_tree().get_nodes_in_group("player").front()

var canShoot = false
var canFire = true
var patternLoop = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	if owl1ref.get_ref():
		owl1.ready()
		owl1Health.wait_time = 3
	if owl2ref.get_ref():
		owl2.ready()
		owl2Health.wait_time = 10
	time.start() #Starts timer
	
#Plays the first stage enemy form
func _on_Start_timeout():
	anim.current_animation = "New Anim"
	$Shoot.start()
	
	if owl2ref.get_ref():
		
		owl2.add_child(add2Instanced)
		add2Instanced.global_position = owl2.global_position
	if owl1ref.get_ref():
		owl1.add_child(add1Instanced)
		owl1.add_child(add3Instanced)
		add3Instanced.global_position = owl1.global_position

	
	
	BHPatternManager.register_bullet_container(get_parent())
	

	

#Kills scene after some time
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

#Disable
func _on_bull_timeout():
	if owl1ref.get_ref():	
		add1Instanced.disable()
	if owl2ref.get_ref():
		yield(get_tree().create_timer(2), "timeout")
		add2Instanced.disable()
	



func _on_Shoot_timeout():
	if owl2ref.get_ref():
		
		add2Instanced.enable()
		add2Instanced.global_position = owl2.global_position
		
	if owl1ref.get_ref():
		
		add1Instanced.enable()
		#add3Instanced.global_position = owl1.global_position
		add1Instanced.global_position = owl1.global_position
		
				
			
		
	bullStart.start()
