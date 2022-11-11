extends Control

onready var fade = $ColorRect/fadeIn
onready var pulsing = $sub/pulse

func _ready():
	pulsing.current_animation = "pulse"


func _exit_tree():
	fade.current_animation = "fadeOut"
