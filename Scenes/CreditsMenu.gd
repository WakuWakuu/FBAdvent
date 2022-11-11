extends Control

onready var backButton = $VBoxContainer/backButton


func _ready():
	backButton.grab_focus()
	pass
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().reappear()
		queue_free()


func _on_backButton_pressed():
	get_parent().reappear()
	queue_free()
