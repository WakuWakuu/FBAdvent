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
onready var boss = load("res://Scenes/enemy_patterns/st1boss.tscn")
#onready var owlGirl = load("res://Scenes/owlGirl.tscn")

var form1Loop = 4
var form2Loop = 5
var form3Loop = 4
var form4Loop = 1

signal bossStart
signal start
signal changeStage

var thread
var form1Instanced
var form2Instanced
var form3Instanced
var form4Instanced

var form2Instanced2

var form1List = []
var form2List = []
var form3List = []
var form3_1List = []
var form4List = []

func _ready():	
	stageStart()
	
	#Instances all the enemy scenes at the start of the stage. Hopefully this results in less lag.
	for i in form1Loop:		
		var form1Instanced = form1.instance()
		form1List.append(form1Instanced)
		add_child(form1List[i])
	
	for i in form2Loop:
		var form2Instanced = form2.instance()
		form2List.append(form2Instanced)
		add_child(form2List[i])
		
	for i in form3Loop:
		var form3Instanced = form3.instance()
		form3List.append(form3Instanced)
		add_child(form3List[i])
	
	for i in form3Loop:
		var form2Instanced2 = form2.instance()
		form3_1List.append(form2Instanced2)
		add_child(form3_1List[i])
		
	for i in form4Loop:
		var form4Instanced = form4.instance()
		form4List.append(form4Instanced)
		add_child(form4List[i])
	

func stageStart():
	$start1.start()


func _on_start1_timeout():

	#First enemy attack
	for i in form1Loop:
		
		form1List[i].ready()
		yield(get_tree().create_timer(3), "timeout")

	yield(get_tree().create_timer(4), "timeout")
	$AnimationPlayer.current_animation = "stage name"
	

func _process(delta):
	pass

	

func _on_AnimationPlayer_animation_finished(anim_name):
	for i in form2Loop:
		form2List[i].ready()
		yield(get_tree().create_timer(2), "timeout")

	yield(get_tree().create_timer(3), "timeout")

	for i in form3Loop:
		form3List[i].ready()
		form3_1List[i].ready()
		yield(get_tree().create_timer(4), "timeout")

	for i in form4Loop:
		form4List[i].ready()
		yield(get_tree().create_timer(6), "timeout")

	$dialogueStart.start()
	

func _on_dialogueStart_timeout():
	var encounterDialogue = Dialogic.start("OG-encounter2")
	add_child(encounterDialogue)
	emit_signal("bossStart")
	var bossInstanced = boss.instance()
	add_child(bossInstanced)
	
	while Dialogic.has_current_dialog_node():
		yield(get_tree().create_timer(0.5), "timeout")
		pass
	if !Dialogic.has_current_dialog_node():
		get_parent().get_parent().get_node("Music/boss1").play()
		get_parent().get_parent().get_node("Music/stage1").stop()
		bossInstanced.started()
	while !bossInstanced.isDefeated():
		yield(get_tree().create_timer(0.5), "timeout")
		pass
	var defeated = Dialogic.start("OG-defeated2")
	add_child(defeated)
	while Dialogic.has_current_dialog_node():
		yield(get_tree().create_timer(0.5), "timeout")
		pass
	if !Dialogic.has_current_dialog_node():
		emit_signal("changeStage")
		get_parent().get_parent().get_node("Music/boss1").stop()
		

