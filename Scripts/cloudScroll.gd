extends CanvasLayer

onready var clouds = $Clouds
onready var cloudInstance = load("res://Scenes/Cloud.tscn")

onready var defaultPos = 0
onready var scrollSpeed : float = 50

var randPos = rand_range(320, 930)

var canSpawn = true

var cloudSpawned

func _ready():
	spawnCloud()

func spawnCloud():
	
	while canSpawn:		
		cloudSpawned = cloudInstance.instance()
		add_child(cloudSpawned)
		cloudSpawned.global_position = Vector2(rand_range(320, 930), -300)
		yield(get_tree().create_timer(3), "timeout")

