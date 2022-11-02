extends Node2D

var canShoot = false
var pattern : BulletHellperPattern
onready var player = get_tree().get_nodes_in_group("player").front()
onready var playerHitbox = player.get_children()

#Enemy forms (Scenes with enemy attacks and paths)
onready var form1 = load("res://Scenes/enemy_patterns/st1form1.tscn")
onready var form2 = load("res://Scenes/enemy_patterns/st1form2.tscn")
onready var form3 = load("res://Scenes/enemy_patterns/st1form3.tscn")
onready var form4 = load("res://Scenes/enemy_patterns/st1form4.tscn")
onready var miniBoss = load("res://Scenes/enemy_patterns/st1MiniBoss.tscn")
onready var boss = load("res://Scenes/owlGirl.tscn")

var form1Loop = 4
var form2Loop = 5
var form3Loop = 4
var form4Loop = 1


func _ready():
	$start1.start()
	



func _on_start1_timeout():

	#First enemy attack
	for i in form1Loop:
		var form1Instanced = form1.instance()
		add_child(form1Instanced)
		yield(get_tree().create_timer(3), "timeout")

	yield(get_tree().create_timer(4), "timeout")
	$AnimationPlayer.current_animation = "stage name"
	
	
	

func _process(delta):
	pass

	


func _on_AnimationPlayer_animation_finished(anim_name):
	for i in form2Loop:
		var form2Instanced = form2.instance()
		add_child(form2Instanced)
		yield(get_tree().create_timer(2), "timeout")
		
	yield(get_tree().create_timer(3), "timeout")
	
	for i in form3Loop:
		var form3Instanced = form3.instance()
		add_child(form3Instanced)
		var form2Instanced = form2.instance()
		add_child(form2Instanced)
		yield(get_tree().create_timer(4), "timeout")
		
	for i in form4Loop:
		var form4Instanced = form4.instance()
		add_child(form4Instanced)
		yield(get_tree().create_timer(6), "timeout")
	#add_child(bossInstanced)
	#bossInstanced.global_position = player.global_position
	

	