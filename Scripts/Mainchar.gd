extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass
func movement_added(movement):
	move_and_collide(movement)

func _process(delta):
	if (is_network_master()):
		
		var movement=Vector2(0,0)
		if(Input.is_action_pressed("walkup")):
			print("up")
			movement+=Vector2(-32,-24)
			$Sprite.region_rect=Rect2(0,0,64,128)
		if(Input.is_action_pressed("walkdown")):
			print("down")
			movement+=Vector2(32,24)
			$Sprite.region_rect=Rect2(192,0,64,128)
		if(Input.is_action_pressed("walkright")):
			print("right")
			movement+=Vector2(32,-24)
			$Sprite.region_rect=Rect2(128,0,64,128)
		if(Input.is_action_pressed("walkleft")):
			print("left")
			movement+=Vector2(-32,24)
			$Sprite.region_rect=Rect2(64,0,64,128)
		movement*=delta*5
		rpc_unreliable("movement_added",movement)
		#move_and_collide(movement)
	#move_and_slide(movement)
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
