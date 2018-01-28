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
var fraction=0


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	frame=(randi()%4)*64
	if(randi()%2==1):
		var npcimage=Image.new()
		npcimage.load("Assets/Characters/NPCFemaleBlueAll.png")
		var npctex=ImageTexture.new()
		npctex.create_from_image(npcimage,0)
		get_node("Sprite").texture=npctex
	pass
slave func movement_added(movement,rotslave,frameslave):
	move_and_collide(movement)
	$Sprite.region_rect=Rect2(frameslave,rotslave,64,128)
slave func updatedfraction(movement,rotslave,frameslave):
	move_and_collide(movement)
	$Sprite.region_rect=Rect2(frameslave,rotslave,64,128)
func go(movement):
	
	move_and_collide(movement)
	
	if(movement.x<0 and movement.y<=0):
		npcrot=128
	elif(movement.x>=0 and movement.y<=0):
		npcrot=0
	elif(movement.x>=0 and movement.y>0):
		npcrot=384
	else:
		npcrot=256
	
	rpc_unreliable("movement_added",movement,npcrot,frame)
	get_node("Sprite").region_rect=Rect2(frame,npcrot,64,128)
func _process(delta):
	var randright=randf()-0.5
	var randleft=randf()-0.5
	#print(str(randright)+" / "+str(randleft))
	accel=Vector2((randleft),(randright))
	motion=(accel+motion).normalized()*6
	if held:
		anim+=delta*10
		frame=(int(anim)%4)*64
	else: 
		anim+=delta
		frame=(int(anim)%4)*64
	if get_tree().is_network_server():
		go(motion*delta)
	#fraction-=5*delta
	var bodenObjekte=get_parent().get_parent().get_node("BodenObjekte")
	for rote_antenne in bodenObjekte.antenneR:
		if(rote_antenne[2]):
			var antpos=bodenObjekte.map_to_world(Vector2(rote_antenne[0],rote_antenne[1]))
			var distAnt=antpos.distance_to(position)
			if(distAnt<200):
				fraction+=(200-distAnt)*delta/20
	for gruene_antenne in bodenObjekte.antenneG:
		if(gruene_antenne[2]):
			var antpos=bodenObjekte.map_to_world(Vector2(gruene_antenne[0],gruene_antenne[1]))
			var distAnt=antpos.distance_to(position)
			if(distAnt<200):
				fraction-=(200-distAnt)*delta/20
	updatefraction()

func updatefraction():
	var colormod
	if(fraction>=0):
		colormod=Color(1.0,1-0.01*fraction,1-0.01*fraction,1.0)
	else:
		colormod=Color(1.0+0.01*fraction,1.0,1.0+0.01*fraction,1.0)
	$HSlider.modulate=colormod
	$HSlider.value=fraction
	if(fraction>20):
		if not global.npcs[0].has(self):
			global.npcs[0].append(self)
			rpc_unreliable("updatedfraction",global.npcs)
		if global.npcs[1].has(self):
			global.npcs[1].remove(global.npcs[1].find(self))
			rpc_unreliable("updatedfraction",global.npcs)
		if global.npcs[2].has(self):
			global.npcs[2].remove(global.npcs[2].find(self))
			rpc_unreliable("updatedfraction",global.npcs)
	elif(fraction<-20):
		if not global.npcs[1].has(self):
			global.npcs[1].append(self)
			rpc_unreliable("updatedfraction",global.npcs)
		if global.npcs[0].has(self):
			global.npcs[0].remove(global.npcs[0].find(self))
			rpc_unreliable("updatedfraction",global.npcs)
		if global.npcs[2].has(self):
			global.npcs[2].remove(global.npcs[2].find(self))
			rpc_unreliable("updatedfraction",global.npcs)
	else:
		if not global.npcs[2].has(self):
			global.npcs[2].append(self)
			rpc_unreliable("updatedfraction",global.npcs)
		if global.npcs[1].has(self):
			global.npcs[1].remove(global.npcs[1].find(self))
			rpc_unreliable("updatedfraction",global.npcs)
		if global.npcs[0].has(self):
			global.npcs[0].remove(global.npcs[0].find(self))
			rpc_unreliable("updatedfraction",global.npcs)
	

#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
