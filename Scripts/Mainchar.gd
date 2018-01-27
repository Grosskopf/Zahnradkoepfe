extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var playerrot=0
var frame=256
var anim=0
var moving=false
var holding=null
var movement_player=Vector2(0,0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print("ready")
	set_process(true)
	pass
slave func movement_added(movement,rotslave,frameslave,npcnr):
	move_and_collide(movement)
	$Sprite.region_rect=Rect2(frameslave,rotslave,64,128)
	if(npcnr!=-1):
		get_parent().get_parent().movables[npcnr].go(movement)
	#if holding_slave!=null and holding_slave.get_class()=="KinematicBody2D" and not holding_slave.get_groups().empty() and holding_slave.get_groups()[0]=="NPC":
	#	holding.motion=movement
#		holding_slave.move_and_collide(movement)
#		if(moving):
#			holding_slave.get_node("Sprite").region_rect=Rect2(holding_slave.frame,rotslave,64,128)
#		else:
#			holding_slave.get_node("Sprite").region_rect=Rect2(256,rotslave,64,128)
slave func added_cable(posx,posy):
	get_parent().get_parent().get_node("BodenObjekte").add_cable(posx,posy)
func _process(delta):
	if (is_network_master()):
		$Camera2D.current=true
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
		rpc_unreliable("movement_added",movement,playerrot,frame,get_parent().get_parent().movables.find(holding))
		$Sprite.region_rect=Rect2(frame,playerrot,64,128)
		var collisions = move_and_collide(movement)
		#movement_player=movement
		if not holding==null and holding.get_class()=="KinematicBody2D" and not holding.get_groups().empty() and holding.get_groups()[0]=="Movables":
			holding.motion=movement
		#	#if(moving):
		#	#	holding.get_node("Sprite").region_rect=Rect2(holding.frame,playerrot,64,128)
		#	#else:
		#	#	holding.get_node("Sprite").region_rect=Rect2(256,playerrot,64,128)
		
		if not Input.is_action_pressed("interact"):
			holding=null
		#if(collisions!=null):
		#	print(collisions.collider.get_name())
		if(Input.is_action_pressed("interact")):
			if(playerrot==128):
				if($RayTop.is_colliding() && not $RayTop.get_collider().get_groups().empty() && $RayTop.get_collider().get_groups()[0]=="Movables"):
					holding=$RayTop.get_collider()
					holding.held=true
			elif(playerrot==256):
				if($RayLeft.is_colliding() && not $RayLeft.get_collider().get_groups().empty() && $RayLeft.get_collider().get_groups()[0]=="Movables"):
					holding=$RayLeft.get_collider()
					holding.held=true
			elif(playerrot==384):
				if($RayBottom.is_colliding() && not $RayBottom.get_collider().get_groups().empty() && $RayBottom.get_collider().get_groups()[0]=="Movables"):
					holding=$RayBottom.get_collider()
					holding.held=true
			elif(playerrot==0):
				if($RayRight.is_colliding() && not $RayRight.get_collider().get_groups().empty() && $RayRight.get_collider().get_groups()[0]=="Movables"):
					holding=$RayRight.get_collider()
					holding.held=true
		if Input.is_action_pressed("cableadd"):
			rpc_unreliable("added_cable",position.x,position.y)
			get_parent().get_parent().get_node("BodenObjekte").add_cable(position.x,position.y)
		#move_and_collide(movement)
	#move_and_slide(movement)
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
