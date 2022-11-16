extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func ready():
	$anim.seek(0.0, true)
	$anim.current_animation = "slide"
	
