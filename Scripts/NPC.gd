extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var held=false
var motion=Vector2(0,0)
var accel=Vector2(0,0)
var anim=0
var frame
var npcrot

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	frame=(randi()%4)*64
	pass

func _process(delta):
	var randright=randf()-0.5
	var randleft=randf()-0.5
	print(str(randright)+" / "+str(randleft))
	accel=Vector2((randleft),(randright))
	motion=(accel+motion).normalized()*6
	if held:
		anim+=delta*10
		frame=(int(anim)%4)*64
	else: 
		anim+=delta
		frame=(int(anim)%4)*64
		move_and_collide(motion*delta)
		if(motion.x<0 and motion.y<=0):
			npcrot=128
		elif(motion.x>=0 and motion.y<=0):
			npcrot=0
		elif(motion.x>=0 and motion.y>0):
			npcrot=384
		else:
			npcrot=256
		get_node("Sprite").region_rect=Rect2(frame,npcrot,64,128)
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass