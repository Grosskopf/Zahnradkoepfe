extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	$Player1/ProgressBar.value=len(global.npcs[0])
	$Player2/ProgressBar.value=len(global.npcs[1])
	if(get_tree().is_network_server()):
		$Resources/Label.text=str(global.resources[0])
	else:
		$Resources/Label.text=str(global.resources[1])
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
