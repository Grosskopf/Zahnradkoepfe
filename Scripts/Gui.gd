extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var sounds=[load("res://Sound/Stromsound.tscn"),load("res://Sound/Generatorsound.tscn"),load("res://Sound/Antennesound.tscn")]
#onready var flag_scene = load("location of flag.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass

func _process(delta):
	$Player1/ProgressBar.value=len(global.npcs[0])
	$Player2/ProgressBar.value=len(global.npcs[1])
	if(get_tree().is_network_server()):
		$Resources/Label.text=str(int(global.resources[0]))
		$Inventory/Cables.text=str(global.inventory[0][0])
		$Inventory/Cables2.text=str(global.inventory[0][1])
		$Inventory/Cables3.text=str(global.inventory[0][2])
	else:
		$Resources/Label.text=str(int(global.resources[1]))
		$Inventory/Cables.text=str(global.inventory[1][0])
		$Inventory/Cables2.text=str(global.inventory[1][1])
		$Inventory/Cables3.text=str(global.inventory[1][2])
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
