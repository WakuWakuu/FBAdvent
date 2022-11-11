extends Control


onready var startButton = $Main/Main/Start
onready var optionsButton = $Main/Main/Options
onready var creditsButton = $Main/Main/Credits
onready var quitButton = $Main/Main/Quit
onready var selectSFX = $select
onready var selectSFXPressed = $select2
onready var credits = load("res://Scenes/CreditsMenu.tscn")

func _ready():
	startButton.grab_focus()


func _on_Start_pressed():
	selectSFXPressed.play()
	get_tree().change_scene("res://Scene.tscn")


func _on_Options_pressed():
	selectSFXPressed.play()


func _on_Credits_pressed():	
	selectSFXPressed.play()
	var creditsMenu = credits.instance()
	add_child(creditsMenu)
	$Main.visible = false
	


func _on_Quit_pressed():
	get_tree().quit()


#Plays SFX
func _on_Start_focus_entered():
	selectSFX.play()


func _on_Options_focus_entered():
	selectSFX.play()


func _on_Credits_focus_entered():
	selectSFX.play()


func _on_Quit_focus_entered():
	selectSFX.play()

func reappear():
	$Main.visible = true
	startButton.grab_focus()
