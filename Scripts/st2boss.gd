extends Node2D


onready var anim = $animations
onready var time = $Start
onready var bullStart = $bull
onready var healthBar = $GUI/HealthBar
onready var spellName = $GUI/SpellName

onready var add1 = load("res://Scenes/patterns/leatt1.tscn")
onready var add2 = load("res://Scenes/patterns/leatt2.tscn")
onready var add3 = load("res://Scenes/patterns/owlminiatt1.tscn")
onready var add4 = load("res://Scenes/patterns/leatt5.tscn")
onready var add5 = load("res://Scenes/patterns/leatt6.tscn")
onready var add6 = load("res://Scenes/patterns/leatt4.tscn")
onready var boss = $lemurGirl
onready var bossHealth = $lemurGirl/Health
onready var clear = $lemurGirl/bulletPhaseClear

onready var bossref = weakref(boss)
onready var bossPos = $lemurGirl/Position2D

onready var att1 = add1.instance()
onready var att2 = add2.instance()
onready var att3 = add3.instance()
onready var att4 = add4.instance()
onready var att5 = add5.instance()
onready var att6 = add6.instance()

onready var player = get_tree().get_nodes_in_group("player").front()

var canShoot = false
var canSpin = false
var spinDirec = 0.0
var canKill = false

var thread

var defeated = false


func _ready():
	start()

	

func start():
	
	yield(get_tree().create_timer(3), "timeout")
	$fadeIn.current_animation = "fadeIn"
	anim.current_animation = "flyIn"

func started():
	time.start() #Starts timer
	
func _process(delta):
	healthBar.value = boss.giveHealth()
	healthBar.max_value = bossHealth.wait_time



func _on_Start_timeout():
	boss.enableDamage()
	
	$Shoot.start()
	
	if bossref.get_ref():
		boss.add_child(att1)

		att1.global_position = boss.global_position

	
	
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
		spellName.text = " Spell:『Thorns That Defend the Rose』"
		anim.playback_speed = 0.6
		anim.playback_default_blend_time = 1.5
		#anim.current_animation = "phase1"
		att1.global_position = boss.global_position
		#att2.global_position = owl1.global_position

		#att1.get_node("Aim").set_aim_target(player)			
		att1.enable()

		while BHPatternManager.bossClearCheck(clear) == false:
			yield(get_tree().create_timer(0.1), "timeout")
		att1.disable()

	bullStart.start()


func _on_OwlGirl_phase1End():
	if bossref.get_ref():
		
		spellName.text = " Spell:『Water Lotus』"
		anim.playback_speed = 1
		anim.playback_default_blend_time = 0.8
		#anim.current_animation = "phase2"
		canSpin = false
		att1.disable()
		yield(get_tree().create_timer(1), "timeout")

		boss.add_child(att2)
		att2.global_position = boss.global_position

		att2.set_aim_target(player)

		att2.enable()
		while BHPatternManager.bossClearCheck(clear) == false:
			yield(get_tree().create_timer(0.1), "timeout")

		att2.disable()
		

func _on_OwlGirl_phase2End():

	if bossref.get_ref():
		spellName.text = " Spell:『The Balance of the Earth』"
		att2.disable()

		boss.add_child(att3)
		att3.global_position = boss.global_position
		att3.set_aim_target(player)
		while BHPatternManager.bossClearCheck(clear) == true:
			yield(get_tree().create_timer(0.1), "timeout")
		att3.enable()
		while BHPatternManager.bossClearCheck(clear) == false:
			yield(get_tree().create_timer(0.1), "timeout")
		att3.disable()

func _on_OwlGirl_phase3End():
	if bossref.get_ref():
		spellName.text = " Spell:『The Grass Dance』"
		anim.playback_speed = 1.2
		anim.playback_default_blend_time = 1.5
		#anim.current_animation = "phase4"
		att3.disable()
		yield(get_tree().create_timer(1), "timeout")
		boss.add_child(att4)
		att4.global_position = boss.global_position

		att4.set_aim_target(player)	
		while BHPatternManager.bossClearCheck(clear) == true:
			yield(get_tree().create_timer(0.1), "timeout")
		att4.enable()
		while BHPatternManager.bossClearCheck(clear) == false:
			att4.rotating_speed = att4.rotating_speed * 1.02
			if att4.rotating_speed >= 300:
				att4.rotating_speed = 5
			yield(get_tree().create_timer(0.1), "timeout")
		att4.disable()


func _on_OwlGirl_phase4End():
	if bossref.get_ref():
		spellName.text = " Spell:『Poison』"
		att4.disable()
		boss.add_child(att5)
		att5.global_position = boss.global_position
		att5.set_aim_target(player)
		while BHPatternManager.bossClearCheck(clear) == true:
			yield(get_tree().create_timer(0.1), "timeout")
		att5.enable()
		while BHPatternManager.bossClearCheck(clear) == false:
			yield(get_tree().create_timer(0.1), "timeout")
		att5.disable()


func _on_OwlGirl_phase5End():
	if bossref.get_ref():
		spellName.text = " Spell:『Field of Hopes ~ Field of Grace』"
		att5.disable()
		boss.add_child(att6)
		att6.global_position = boss.global_position
		att6.set_aim_target(player)
		while BHPatternManager.bossClearCheck(clear) == true:
			yield(get_tree().create_timer(0.1), "timeout")
		att6.enable()
		while BHPatternManager.bossClearCheck(clear) == false:
			yield(get_tree().create_timer(0.1), "timeout")
		att6.disable()

func _on_OwlGirl_fightEnd():
	anim.playback_default_blend_time = 0.8
	anim.current_animation = "phase2"
	spellName.text = "「DEFEATED」"
	att6.disable()
	healthBar.visible = false
	defeated = true
	
	
	
	
#I can't get this function to work :(
#I might need to go in and alter BulletHellper's code
func spin(att, spinSpeed : float):
	while canSpin == true:
		spinDirec += spinSpeed
		att.set_direction(Vector2(0.0, spinDirec))
		print(att.direction)
		yield(get_tree().create_timer(0.1), "timeout")

func isDefeated():
	if defeated:
		return true		
	else:
		return false

#func flyOut():
#	yield(get_tree().create_timer(1), "timeout")
#	while Dialogic.has_current_dialog_node():
#		pass
#	anim.current_animation = "flyOut"
#	canKill = true
	


#func _on_animations_animation_finished(anim_name):
#	if canKill == true:
#		queue_free()
