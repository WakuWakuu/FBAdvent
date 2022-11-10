extends CanvasLayer

onready var clouds = $Clouds
onready var cloudInstance = load("res://Scenes/Cloud.tscn")

onready var defaultPos = 0
onready var scrollSpeed : float = 50

var canSpawn = true

var cloudSpawned

var thread

func _ready():
	thread = Thread.new()
	thread.start(self, "spawnCloud")
	#spawnCloud()

func spawnCloud():
	
	while canSpawn:		
		cloudSpawned = cloudInstance.instance()
		add_child(cloudSpawned)
		cloudSpawned.global_position = Vector2(rand_range(300, 930), -300)
		yield(get_tree().create_timer(3), "timeout")

