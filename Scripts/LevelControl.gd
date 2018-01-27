extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var npcs=[]

func _ready():
	if (get_tree().is_network_server()):		
		#if in the server, get control of player 2 to the other peeer, this function is tree recursive by default
		get_node("Objekte/Player2").set_network_master(get_tree().get_network_connected_peers()[0])
	else:
		#if in the client, give control of player 2 to itself, this function is tree recursive by default
		get_node("Objekte/Player2").set_network_master(get_tree().get_network_unique_id())
		
	var player2image=Image.new()
	player2image.load("Assets/Characters/Player2All.png")
	var player2tex=ImageTexture.new()
	player2tex.create_from_image(player2image,0)
	get_node("Objekte/Player2/Sprite").texture=player2tex
	for object in get_node("Objekte").get_children():
		if object.is_in_group("NPC"):
			npcs.append(object)
	pass

#func _process(delta):
#	if get_tree().is_network_server():
#		
	#	if $Objekte/Player1.holding!=null and $Objekte/Objekte/Player1.holding.get_class()=="KinematicBody2D":
	#		$Objekte/Player1.holding.go($Objekte/Player1.movement_player*delta)
	#	$Objekte/Player1.movement_player=Vector2(0,0)
	#	if $Objekte/Player2.holding!=null and $Objekte/Objekte/Player2.holding.get_class()=="KinematicBody2D":
	#		$Objekte/Player2.holding.go($Objekte/Player2.movement_player*delta)
	#	$Objekte/Player2.movement_player=Vector2(0,0)
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
