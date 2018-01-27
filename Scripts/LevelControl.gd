extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	if (get_tree().is_network_server()):		
		#if in the server, get control of player 2 to the other peeer, this function is tree recursive by default
		get_node("Objekte/Player2").set_network_master(get_tree().get_network_connected_peers()[0])
	else:
		#if in the client, give control of player 2 to itself, this function is tree recursive by default
		get_node("Objekte/Player2").set_network_master(get_tree().get_network_unique_id())
		
	var player2image=Image.new()
	player2image.load("Assets/Vorlage/Player2All.png")
	var player2tex=ImageTexture.new()
	player2tex.create_from_image(player2image,0)
	get_node("Objekte/Player2/Sprite").texture=player2tex
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
