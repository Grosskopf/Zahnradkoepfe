extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var animatedtilesarray3=[]
var animatedtiles3nums=[8,11,14,17,20,23,26,29,32,35,38]
var frame3=0

var cables=[[]]
var cablesactive=[]


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	for animatedtile3num in animatedtiles3nums:
		animatedtilesarray3.append(get_used_cells_by_id(animatedtile3num))
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func add_cable(xpos,ypos):
	var mappos=Vector2()
	mappos=world_to_map(Vector2(xpos,ypos))
	var xposmap=mappos.x
	var cabletopright=-1
	var cablebottomright=-1
	var cablebottomleft=-1
	var cabletopleft=-1
	var topright_has=false
	var bottomright_has=false
	var bottomleft_has=false
	var topleft_has=false
	if (int(xposmap)%2)==0:
		cabletopright=find_cable((mappos+Vector2(1,-1)).x,(mappos+Vector2(1,-1)).y)
		topright_has=cabletopright<0
		cablebottomright=find_cable((mappos+Vector2(1,0)).x,(mappos+Vector2(1,0)).y)!=-1
		bottomright_has=cablebottomright<0
		cabletopleft=find_cable((mappos+Vector2(-1,-1)).x,(mappos+Vector2(-1,-1)).y)!=-1
		topleft_has=cabletopleft<0
		cablebottomleft=find_cable((mappos+Vector2(-1,0)).x,(mappos+Vector2(-1,0)).y)!=-1
		bottomleft_has=cablebottomleft<0
	else:
		cabletopright=find_cable((mappos+Vector2(1,1)).x,(mappos+Vector2(1,1)).y)
		topright_has=cabletopright<0
		cablebottomright=find_cable((mappos+Vector2(1,0)).x,(mappos+Vector2(1,0)).y)!=-1
		bottomright_has=cablebottomright<0
		cabletopleft=find_cable((mappos+Vector2(-1,1)).x,(mappos+Vector2(-1,1)).y)!=-1
		topleft_has=cabletopleft<0
		cablebottomleft=find_cable((mappos+Vector2(-1,0)).x,(mappos+Vector2(-1,0)).y)!=-1
		bottomleft_has=cablebottomleft<0
	var currenttoset=4
	var cabletoadd=-1
	if(not topright_has && bottomright_has && bottomleft_has && not topleft_has):
		currenttoset=0
		if(cablebottomleft!=cablebottomright):
			cabletoadd=mergecables(cablebottomleft,cablebottomright)
		else:
			cabletoadd=cablebottomleft
	elif(topright_has && not bottomright_has && not bottomleft_has && topleft_has):
		currenttoset=1
		if(cabletopleft!=cabletopright):
			cabletoadd=mergecables(cabletopleft,cabletopright)
		else:
			cabletoadd=cabletopleft
	elif(topright_has && bottomright_has && not bottomleft_has && not topleft_has):
		currenttoset=2
		if(cabletopright!=cablebottomright):
			cabletoadd=mergecables(cabletopright,cablebottomright)
		else:
			cabletoadd=cabletopright
	elif(not topright_has && not bottomright_has && bottomleft_has && topleft_has):
		currenttoset=3
		if(cablebottomleft!=cabletopleft):
			cabletoadd=mergecables(cabletopleft,cablebottomleft)
		else:
			cabletoadd=cabletopleft
	elif(topright_has && not bottomright_has && bottomleft_has && not topleft_has):
		currenttoset=4
		if(cablebottomleft!=cabletopright):
			cabletoadd=mergecables(cabletopright,cablebottomleft)
		else:
			cabletoadd=cabletopright
	elif(not topright_has && not bottomright_has && bottomleft_has && not topleft_has):
		currenttoset=4
		cabletoadd=cablebottomleft
	elif(topright_has && not bottomright_has && not bottomleft_has && not topleft_has):
		currenttoset=4
		cabletoadd=cabletopright
	elif(not topright_has && bottomright_has && not bottomleft_has && topleft_has):
		currenttoset=5
		if(cablebottomright!=cabletopleft):
			cabletoadd=mergecables(cabletopleft,cablebottomright)
		else:
			cabletoadd=cabletopleft
	elif(not topright_has && not bottomright_has && not bottomleft_has && topleft_has):
		currenttoset=5
		cabletoadd=cabletopleft
	elif(not topright_has && bottomright_has && not bottomleft_has && not topleft_has):
		currenttoset=5
		cabletoadd=cablebottomright
	elif(not topright_has && bottomright_has && bottomleft_has && topleft_has):
		currenttoset=6
		if(cablebottomright!=cablebottomleft or cablebottomright!=cabletopleft):
			cabletoadd=mergecables(cablebottomleft,cabletopleft,cablebottomright)
		else:
			cabletoadd=cabletopleft
	elif(topright_has && not bottomright_has && bottomleft_has && topleft_has):
		currenttoset=7
		if(cabletopright!=cablebottomleft or cabletopright!=cabletopleft):
			cabletoadd=mergecables(cablebottomleft,cabletopleft,cabletopright)
		else:
			cabletoadd=cabletopleft
	elif(topright_has && bottomright_has && not bottomleft_has && topleft_has):
		currenttoset=8
		if(cabletopright!=cablebottomright or cabletopright!=cabletopleft):
			cabletoadd=mergecables(cablebottomright,cabletopleft,cabletopright)
		else:
			cabletoadd=cabletopleft
	elif(topright_has && bottomright_has && bottomleft_has && not topleft_has):
		currenttoset=9
		if(cablebottomright!=cablebottomleft or cablebottomright!=cabletopright):
			cabletoadd=mergecables(cablebottomleft,cabletopright,cablebottomright)
		else:
			cabletoadd=cabletopright
	elif(topright_has && bottomright_has && bottomleft_has && topleft_has):
		currenttoset=10
		if(cablebottomright!=cablebottomleft or cablebottomright!=cabletopright or cablebottomright!=cabletopleft):
			cabletoadd=mergecables(cablebottomleft,cabletopright,cablebottomright,cabletopleft)
		else:
			cabletoadd=cabletopright
	if(cabletoadd==-1):
		cables.append([[mappos.x,mappos.y,currenttoset]])
		cablesactive.append(false)
		set_cell(mappos.x,mappos.y,41+currenttoset)
	else:
		cables[cabletoadd].append([mappos.x,mappos.y,currenttoset])
		if(cablesactive[cabletoadd]):
			set_cell(mappos.x,mappos.y,animatedtiles3nums[currenttoset])
		else:
			set_cell(mappos.x,mappos.y,41+currenttoset)

func mergecables(cable1,cable2,cable3=-1,cable4=-1):
	var cablestomerge=[cable1]
	if(cable2>cable1):
		cablestomerge.push_back(cable2)
	else:
		cablestomerge.push_front(cable2)
	if(cable3!=-1 and cable3<cablestomerge[0]):
		cablestomerge.push_front(cable3)
	elif cable3!=-1 and len(cablestomerge)>1 and cable3!=cablestomerge[1]:
		cablestomerge.push_back(cable3)
	if(cable4!=-1 and cable4<cablestomerge[0]):
		cablestomerge.push_front(cable4)
	elif cable4!=-1 and not cablestomerge.has(cable4):
		cablestomerge.push_back(cable4)
	cablestomerge=cablestomerge.sort()
	for segment in cables[cablestomerge[1]]:
		cables[cablestomerge[0]].append(segment)
	#cables[cablestomerge[0]].push_back(cables[cablestomerge[1]])
	if(len(cablestomerge)>2):
		for segment in cables[cablestomerge[2]]:
			cables[cablestomerge[0]].append(segment)
	#	cables[cablestomerge[0]].push_back(cables[cablestomerge[2]])
	if(len(cablestomerge)>3):
		for segment in cables[cablestomerge[3]]:
			cables[cablestomerge[0]].append(segment)
	#	cables[cablestomerge[0]].push_back(cables[cablestomerge[3]])
	if(len(cablestomerge)>3):
		cables.remove(cablestomerge[3])
		cablesactive.remove(cablestomerge[3])
	if(len(cablestomerge)>2):
		cables.remove(cablestomerge[2])
		cablesactive.remove(cablestomerge[2])
	cables.remove(cablestomerge[1])
	cablesactive.remove(cablestomerge[1])
	return cablestomerge[0]

func find_cable(xpos,ypos):
	for cable in range(len(cables)):
		for segment in cables[cable]:
			if(segment[0]==xpos and segment[1]==ypos):
				return cable
	return -1

func _on_Timer_timeout():
	frame3=(frame3+1)%3
	for animatedtilearray3num in range(len(animatedtilesarray3)):
		for animatedtile in animatedtilesarray3[animatedtilearray3num]:
			set_cell(animatedtile.x,animatedtile.y,animatedtiles3nums[animatedtilearray3num]+frame3)
	for cablenr in range(len(cablesactive)):
		if(cablesactive[cablenr]):
			for animatedtile in cables[cablenr]:
				set_cell(animatedtile[0],animatedtile[1],animatedtiles3nums[animatedtile[2]]+frame3)
	pass # replace with function body
