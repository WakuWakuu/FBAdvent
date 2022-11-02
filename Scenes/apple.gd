extends Area2D


onready var applePos = $Position2D
onready var appleSpeed = 100
onready var canFall = false
onready var rootScene = get_parent().get_parent().get_parent()

signal appleCollected

func _physics_process(delta):
	if $Fall.is_stopped():
		$Fall.start()
	if canFall == true:
		position.y += appleSpeed * delta
	
	if $Kill.is_stopped():
		$Kill.start()

func _on_Apple_area_entered(area):
	if area.name == "meleeArea":
		#$sfx.play()
		yield(get_tree().create_timer(0.1), "timeout")
		#rootScene.connect("appleCollected", rootScene, "appleCount")
		emit_signal("appleCollected")
		queue_free()


func _on_Timer_timeout():
	$Kill.stop()
	queue_free()
	
func _on_Fall_timeout():
	canFall = true
