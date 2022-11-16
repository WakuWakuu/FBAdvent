extends Control


onready var backButton = $Options/Back

onready var selectSFX = $select
onready var selectSFXPressed = $select2
onready var volumeSFX = $volumeNoise
onready var saveFile = "user://save.txt"

var debug = false

func _ready():
	backButton.grab_focus()




func _on_volSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value - 50)
	volumeSFX.play()


func _on_Debug_Mode_toggled(button_pressed):
	selectSFXPressed.play()
	if button_pressed == true:
		debug = true
		#saveDebugMode()
	else:
		debug = false
		print(debug)


func _on_Back_pressed():
	get_parent().reappear()
	queue_free()

#func saveDebugMode():
#	var save = File.new()
#	save.open(saveFile, File.WRITE)
#	save.store_var(debug)
#	save.close()
