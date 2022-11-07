extends Node2D


onready var anim = $animations
onready var time = $Start
onready var bullStart = $bull
onready var healthBar = $Health/HealthBar

onready var add1 = load("res://Scenes/patterns/owlatt1.tscn")
onready var add2 = load("res://Scenes/patterns/owlatt2.tscn")
onready var add2_1 = load("res://Scenes/patterns/add5.tscn")
onready var add3 = load("res://Scenes/patterns/owlatt3.tscn")
onready var add3_1 = load("res://Scenes/patterns/add11.tscn")
onready var add4 = load("res://Scenes/patterns/owlatt4.tscn")
onready var add4_1 = load("res://Scenes/patterns/add6.tscn")
onready var add4_2 = load("res://Scenes/patterns/add8.tscn")
onready var boss = $OwlGirl
onready var bossHealth = $OwlGirl/Health

onready var bossref = weakref(boss)
onready var bossPos = $OwlGirl/Position2D

onready var att1 = add1.instance()
onready var att2 = add2.instance()
onready var att2_1 = add2_1.instance()
onready var att3 = add3.instance()
onready var att3_1 = add3_1.instance()
onready var att4 = add4.instance()
onready var att4_1 = add4_1.instance()
onready var att4_2 = add4_2.instance()

onready var player = get_tree().get_nodes_in_group("player").front()

var canShoot = false
var canSpin = false
var spinDirec = 0.0

func _ready():
	$fadeIn.current_animation = "fadeIn"
	anim.current_animation = "flyIn"

# Called when the node enters the scene tree for the first time.
func started():
	time.start() #Starts timer
	
func _process(delta):
	healthBar.value = boss.giveHealth()
	healthBar.max_value = bossHealth.wait_time


#Plays the first stage enemy form
func _on_Start_timeout():
	boss.enableDamage()
	
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
		anim.playback_speed = 0.6
		anim.playback_default_blend_time = 1.5
		anim.current_animation = "phase1"
		att1.global_position = boss.global_position
		#att2.global_position = owl1.global_position

		att1.get_node("Aim").set_aim_target(player)
		att1.enable()
		canSpin = true
		spin(att1, 10.0)
		#att2.enable()
		
	bullStart.start()


func _on_OwlGirl_phase1End():
	if bossref.get_ref():
		anim.playback_speed = 1
		anim.playback_default_blend_time = 0.8
		anim.current_animation = "phase2"
		canSpin = false
		att1.disable()
		boss.add_child(att2_1)
		boss.add_child(att2)
		att2.global_position = boss.global_position
		att2_1.global_position = boss.global_position
		att2.set_aim_target(player)
		att2_1.enable()
		att2.enable()
		


func _on_OwlGirl_phase2End():
	if bossref.get_ref():
		att2.disable()
		att2_1.disable()
		boss.add_child(att3)
		att3.global_position = boss.global_position
		att3.set_aim_target(player)
		att3.enable()


func _on_OwlGirl_phase3End():
	if bossref.get_ref():
		anim.playback_default_blend_time = 1.5
		anim.current_animation = "phase4"
		att3.disable()
		yield(get_tree().create_timer(1.5), "timeout")
		boss.add_child(att4)
		att4.global_position = boss.global_position
		
		att4.set_aim_target(player)
		att4.enable()


func _on_OwlGirl_phase4End():
	if bossref.get_ref():
		att4.disable()
		boss.add_child(att4_1)
		att4_1.global_position = boss.global_position
		att4_1.set_aim_target(player)
		att4.enable()
		att4_1.enable()

func _on_OwlGirl_phase5End():
	if bossref.get_ref():
		att4.disable()
		att4_1.disable()
		boss.add_child(att4_2)
		att4_2.global_position = boss.global_position
		att4_2.set_aim_target(player)
		att4.enable()
		att4_1.enable()
		att4_2.enable()

func _on_OwlGirl_fightEnd():
	att4.disable()
	att4_1.disable()
	att4_2.disable()
	healthBar.visible = false
	
	
#I can't get this function to work :(
#I might need to go in and alter BulletHellper's code
func spin(att, spinSpeed : float):
	while canSpin == true:
		spinDirec += spinSpeed
		att.set_direction(Vector2(0.0, spinDirec))
		print(att.direction)
		yield(get_tree().create_timer(0.1), "timeout")

func isDefeated():
	if !healthBar.visible:
		return true
	else:
		return false
