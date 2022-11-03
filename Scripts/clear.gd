extends StaticBody2D


onready var bullets = get_tree().get_nodes_in_group("Bullet")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func is_colliding(pos, radius, bullet):
	pass



