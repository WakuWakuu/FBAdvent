extends AudioStreamPlayer


var rando = rand_range(0.01,0.05)


# Called when the node enters the scene tree for the first time.
func _ready():
	pitch_scale = rand_range(0.9,1.1)
	yield(get_tree().create_timer(rando), "timeout")
	self.play()
