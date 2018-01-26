extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var playerrot=0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass
slave func movement_added(movement,rotslave):
	move_and_collide(movement)
	$Sprite.region_rect=Rect2(rotslave,0,64,128)

func _process(delta):
	if (is_network_master()):
		
		var movement=Vector2(0,0)
		if(Input.is_action_pressed("walkup")):
			movement+=Vector2(-32,-24)
			playerrot=0
		if(Input.is_action_pressed("walkdown")):
			movement+=Vector2(32,24)
			playerrot=192
		if(Input.is_action_pressed("walkright")):
			movement+=Vector2(32,-24)
			playerrot=128
		if(Input.is_action_pressed("walkleft")):
			movement+=Vector2(-32,24)
			playerrot=64
		movement*=delta*5
		rpc_unreliable("movement_added",movement,playerrot)
		$Sprite.region_rect=Rect2(playerrot,0,64,128)
		move_and_collide(movement)
		#move_and_collide(movement)
	#move_and_slide(movement)
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
