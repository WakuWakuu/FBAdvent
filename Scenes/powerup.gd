extends Area2D

onready var powerPos = $Position2D
onready var powerSpeed = 100
onready var canFall = false
#onready var rootScene = get_parent().get_parent().get_parent()

signal powerCollected

func _physics_process(delta):
	if $Fall.is_stopped():
		$Fall.start()
	if canFall == true:
		position.y += powerSpeed * delta
	
	if $Kill.is_stopped():
		$Kill.start()

	
func _on_Fall_timeout():
	canFall = true



func _on_powerUp_area_entered(area):
	if area.name == "meleeArea":
		#$sfx.play()
		yield(get_tree().create_timer(0.1), "timeout")
		#rootScene.connect("appleCollected", rootScene, "appleCount")
		emit_signal("powerCollected")
		queue_free()


func _on_Kill_timeout():
	$Kill.stop()
	queue_free()
