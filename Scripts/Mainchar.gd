extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	var movement=Vector2(0,0)
	if(Input.is_action_pressed("walkup")):
		print("up")
		movement+=Vector2(-32,-24)
	if(Input.is_action_pressed("walkdown")):
		print("down")
		movement+=Vector2(32,24)
	if(Input.is_action_pressed("walkright")):
		print("right")
		movement+=Vector2(32,-24)
	if(Input.is_action_pressed("walkleft")):
		print("left")
		movement+=Vector2(-32,24)
	movement*=delta
	move_and_collide(movement)
	#move_and_slide(movement)
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
