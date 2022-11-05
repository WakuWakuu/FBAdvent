extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _process(delta):
	position.y += 50 * delta
	if position.y >= 900:
		print("died")
		queue_free()

func _ready():
	pass
