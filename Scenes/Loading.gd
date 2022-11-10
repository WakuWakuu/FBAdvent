extends Control

onready var fade = $ColorRect/fadeIn
onready var pulsing = $sub/pulse

func _ready():
	fade.current_animation = "NewAnim"
	

func _on_fadeIn_animation_finished(anim_name):
	pulsing.current_animation = "pulse"
