extends Control


func _ready():
	self.get_focus_owner()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
