extends KinematicBody2D

signal death

onready var velocity = Vector2()
onready var speed

#onready var spawnBullet = get_node("playerBullet")
onready var hitboxSprite = $hitbox
onready var meleeCircle = $melee
onready var bulletScene = load("res://Scenes/playerBullet.tscn")
onready var bigBulletScene = load("res://Scenes/bigBullet.tscn")
onready var canShoot = true
onready var shootingSpeed 
onready var anim = $Sprite

onready var skillMachineGun = $Skills/machineGunSkill
onready var skillBigBullet = $Skills/bigBulletSkill


var bigBullet = false

var machineGun = false
var skillDuration1 = false
var canActivate = true

var skillList = [
	
	"Machine Gun",
	"Sunray Blast"
	
]

#Sets player as a bullet target when game launches
func _ready():
	BHPatternManager.register_bullet_target(self)
	anim.play("default")
	
	
func movement_input():

	#Variables
	velocity = Vector2()
	speed = 340
	hitboxSprite.visible = false
	meleeCircle.visible = false
	if !machineGun:
		shootingSpeed = 0.2
	
	#Movement
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("right"):
		velocity.x += 1
		
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		
	if Input.is_action_pressed("down"):
		velocity.y += 1 
	
	#Focusing and shooting
	if Input.is_action_pressed("focus"):
		speed = 185
		hitboxSprite.visible = true
		meleeCircle.visible = true
		
	
	if Input.is_action_pressed("shoot"):
		if !Dialogic.has_current_dialog_node():
			if canShoot == true:
				#Activates the bullets
				shootBull()
		
	if Input.is_action_just_pressed("skill"):
		if canActivate == true:
			machineGun()
			bigBullet()
			canActivate = false
			
		

	
	#Animation handler
	if velocity.x > 0:
		anim.animation = "right"

	elif velocity.x < 0:
		anim.animation = "left"

	elif velocity.x == 0:
		anim.animation = "default"

		
	#Sets velocity
	velocity = velocity.normalized() * speed
		

#Creates a bullet
func shootBull():
	var bullet = bulletScene.instance()
	get_parent().add_child(bullet)
	bullet.position = $Position2D.global_position
	canShoot = false
	yield(get_tree().create_timer(shootingSpeed), "timeout")
	canShoot = true
	
#Physics
func _physics_process(delta):
	
	movement_input()
	velocity = move_and_slide(velocity)


#This is just here so the game doesn't crash. This is called by the BulletHellper plugin
#whenever the bullet target (the player) is grazing a bullet. There will be no graze counter in this game.

#never knew that the plugin was capable of this lol
func grazed():
	$graze.play()

#Kills player on bullet hit. Function is called by the Bullet Hellper plugin.
func on_hit():
	
	if $invincibility.is_stopped():
		death()
	
func death():
	
	#Overlaying two sound effects because I just found out how cool they sound together
	$deathParticles.emitting = true
	$death2.play()
	$death.play()
	emit_signal("death")
	print("hit")
	$invincibility.start()

func _on_invincibility_timeout():
	pass


func _on_deathTimer_timeout():
	pass 


func _on_Scene_powerSkillActivate():
	
	var skill = randSkill(skillList)
	
	if skill == skillList[0]:
		
		machineGun = true
		
	elif skill == skillList[1]:
		
		bigBullet = true
		

func randSkill(skills):
	return skillList[randi() % skills.size()]

func machineDuration():
	machineGun = false
	canActivate = true

func machineGun():
	skillMachineGun.get_node("powerup").emitting = true
	$skillenable.play()
	if skillMachineGun.get_node("Duration").is_stopped():
		skillMachineGun.get_node("Duration").start()
	while machineGun == true:	
		shootingSpeed = 0.1
		yield(get_tree().create_timer(shootingSpeed), "timeout")
		
	skillMachineGun.get_node("powerup").emitting = false
	#shootingSpeed = 0.2


func bigBullet():
	$skillenable.play()
	if bigBullet == true:
		var bullet = bigBulletScene.instance()
		get_parent().add_child(bullet)
		bullet.position.x = $Position2D.global_position.x
		bullet.position.y = $Position2D.global_position.y - 30
		bigBullet = false
	


func getCurrentSkill():
	if machineGun == true:
		return " Machine Gun"
	elif bigBullet == true:
		return " Sunray Blast"
	else:
		return ""
