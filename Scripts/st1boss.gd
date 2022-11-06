extends Node2D


onready var anim = $AnimationPlayer
onready var time = $Start
onready var bullStart = $bull
onready var healthBar = $Health/HealthBar

onready var add1 = load("res://Scenes/patterns/owlatt1.tscn")
onready var add2 = load("res://Scenes/patterns/owlatt2.tscn")
onready var add3 = load("res://Scenes/patterns/owlatt3.tscn")
onready var add4 = load("res://Scenes/patterns/owlatt4.tscn")
#onready var add4 = load("res://Scenes/patterns/owlatt5.tscn")
onready var boss = $OwlGirl
onready var bossHealth = $OwlGirl/Health

onready var bossref = weakref(boss)
onready var bossPos = $OwlGirl/Position2D

onready var att1 = add1.instance()
onready var att2 = add2.instance()
onready var att3 = add3.instance()
onready var att4 = add4.instance()

onready var player = get_tree().get_nodes_in_group("player").front()

var canShoot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	time.start() #Starts timer
	
func _process(delta):
	healthBar.value = boss.giveHealth()
	healthBar.max_value = bossHealth.wait_time


#Plays the first stage enemy form
func _on_Start_timeout():
	
	anim.current_animation = "New Anim"
	$Shoot.start()
	
	if bossref.get_ref():
		boss.add_child(att1)
		#owl1.add_child(att2)
		#var at1 = att1.get_node("BulletPattern")
		att1.global_position = boss.global_position
		#att2.global_position = owl1.global_position
		#at1.global_position = owl1.global_position
		att1.set_aim_target(player)
		#att2.set_aim_target(player)
	
	
	BHPatternManager.register_bullet_container(get_parent())
	

	

#Kills scene after some time
#func _on_AnimationPlayer_animation_finished(anim_name):
#	queue_free()

#Disable
#func _on_bull_timeout():
#	if bossref.get_ref():
#		att1.disable()



func _on_Shoot_timeout():
	if bossref.get_ref():
		att1.global_position = boss.global_position
		#att2.global_position = owl1.global_position

		att1.set_aim_target(player)
		att1.enable()
		#att2.enable()
		
	bullStart.start()


func _on_OwlGirl_phase1End():
	if bossref.get_ref():
		att1.disable()
		boss.add_child(att2)
		att2.global_position = boss.global_position
		att2.set_aim_target(player)
		att2.enable()


func _on_OwlGirl_phase2End():
	if bossref.get_ref():
		att2.disable()
		boss.add_child(att3)
		att3.global_position = boss.global_position
		att3.set_aim_target(player)
		att3.enable()


func _on_OwlGirl_phase3End():
	if bossref.get_ref():
		att3.disable()
		boss.add_child(att4)
		att4.global_position = boss.global_position
		att4.set_aim_target(player)
		att4.enable()


func _on_OwlGirl_phase4End():
	pass
#	if bossref.get_ref():
#		att4.disable()
#		boss.add_child(att5)
#		att5.global_position = boss.global_position
#		att5.set_aim_target(player)
#		att5.enable()
