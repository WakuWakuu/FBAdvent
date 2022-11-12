extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Buttons/Again.grab_focus()


func _on_Again_pressed():
	$select2.play()
	get_tree().change_scene("res://Scene.tscn")


func _on_Quit_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	$select2.play()


func _on_Again_focus_entered():
	$select.play()


func _on_Quit_focus_entered():
	$select.play()
