extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var playerrot=0
var frame=256
var anim=0
var moving=false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass
slave func movement_added(movement,rotslave,frameslave):
	move_and_collide(movement)
	$Sprite.region_rect=Rect2(frameslave,rotslave,64,128)

func _process(delta):
	if (is_network_master()):
		
		var movement=Vector2(0,0)
		moving=false
		if(Input.is_action_pressed("walkup")):
			movement+=Vector2(-32,-24)
			playerrot=128
			moving=true
		if(Input.is_action_pressed("walkdown")):
			movement+=Vector2(32,24)
			playerrot=384
			moving=true
		if(Input.is_action_pressed("walkright")):
			movement+=Vector2(32,-24)
			playerrot=0
			moving=true
		if(Input.is_action_pressed("walkleft")):
			movement+=Vector2(-32,24)
			playerrot=256
			moving=true
		anim+=delta*10
		if(moving):
			frame=(int(anim)%4)*64
		else:
			frame=256
		movement*=delta*5
		rpc_unreliable("movement_added",movement,playerrot,frame)
		$Sprite.region_rect=Rect2(frame,playerrot,64,128)
		var collisions = move_and_collide(movement)
		
		if(collisions!=null):
			print(collisions.collider.get_name())
		#move_and_collide(movement)
	#move_and_slide(movement)
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
