extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#var animatedtilesarray3=[]
var animatedtiles3nums=[8,11,14,35,17,20,23,26,29,32,38]
var magicnumbers=[4,1,2,3,5,6,0,7,8,9,10]
var frame3=0
var frame4=0
var frame4_2=0

var cables=[]
var cablesactive=[]
var generators=[]
var antenneR=[]
var antenneG=[]



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#for animatedtile3num in animatedtiles3nums:
	#	animatedtilesarray3.append(get_used_cells_by_id(animatedtile3num))
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func add_cable(xpos,ypos):
	var mappos=Vector2()
	mappos=world_to_map(Vector2(xpos,ypos))
	add_cable_intern(mappos)

func add_turm(xpos,ypos,p_rot,player1):
	var mappos=Vector2()
	mappos=world_to_map(Vector2(xpos,ypos))
	var towerpos=Vector2(0,0)
	var neighbours=get_neighbours(mappos)
	
	if(p_rot==0):
		towerpos=neighbours[0]
	elif(p_rot==128):
		towerpos=neighbours[1]
	elif(p_rot==256):
		towerpos=neighbours[2]
	elif(p_rot==384):
		towerpos=neighbours[3]
	add_tower_intern(towerpos,player1)
	for node_test in get_tree().root.get_children():
		if(node_test.has_node("Mainwindow")):
			var towersound = node_test.get_node("Mainwindow").sounds[2].instance()
			towersound.pos=map_to_world(towerpos)
			add_child(towersound)

func add_tower_intern(towerpos,player1):
	#var cablesconnected=remove_cable_intern(generatorpos)
	if(player1):
		set_cell(towerpos.x,towerpos.y,56)
	else:
		set_cell(towerpos.x,towerpos.y,60)
	if(player1):
		antenneR.append([towerpos.x,towerpos.y,false])
	else:
		antenneG.append([towerpos.x,towerpos.y,false])

func add_generator(xpos,ypos,p_rot):
	var mappos=Vector2()
	mappos=world_to_map(Vector2(xpos,ypos))
	var generatorpos=Vector2(0,0)
	var neighbours=get_neighbours(mappos)
	
	if(p_rot==0):
		generatorpos=neighbours[0]
	elif(p_rot==128):
		generatorpos=neighbours[1]
	elif(p_rot==256):
		generatorpos=neighbours[2]
	elif(p_rot==384):
		generatorpos=neighbours[3]
	add_generator_intern(generatorpos)
	for node_test in get_tree().root.get_children():
		if(node_test.has_node("Mainwindow")):
			var generatorsound = node_test.get_node("Mainwindow").sounds[1].instance()
			generatorsound.pos=map_to_world(generatorpos)
			add_child(generatorsound)

func add_generator_intern(generatorpos):
	var cablesconnected=remove_cable_intern(generatorpos)
	print("cablesconnected:")
	print(cablesconnected)
	for cable in cablesconnected:
		cablesactive[cable]=true
		set_cell(generatorpos.x,generatorpos.y,52)
		generators.append([generatorpos.x,generatorpos.y])
	pass

func remove_cable_intern(mappos):
	var tosplitcable=find_cable(mappos.x,mappos.y)
	if tosplitcable==-1:
		return []
	set_cell(mappos.x,mappos.y,-1)
	var checkarray=[]
	var cableleft=[]
	var number=-1
	for elementnr in range(len(cables[tosplitcable])):
		checkarray.append(cables[tosplitcable][elementnr])
		if cables[tosplitcable][elementnr][0]==mappos.x and cables[tosplitcable][elementnr][1]==mappos.y:
			number=elementnr
	cables[tosplitcable].remove(number)
	#checkarray.remove(number)
	#var neighbours=get_neighbours(mappos)
	#for neighbournr in range(4):
	#	for elementnr in range(len(checkarray)):
	#		if checkarray[elementnr][0]==neighbours[neighbournr][0] and checkarray[elementnr][1]==neighbours[neighbournr][1]:
	#			checkarray[elementnr][2]=-(neighbournr+1)
	#var resultarray=get_neighbourspaths(checkarray)
	var resultarrayarray=[]
	for neighbour in get_neighbours(mappos):
		for element in cables[tosplitcable]:
			if element[0]==neighbour[0] and element[1]==neighbour[1]:
				resultarrayarray.append(get_neighbours_check(neighbour))
	var resultarrayarraycopy=[]
	for resultarray in resultarrayarray:
		var has_array=false
		for resaac in resultarrayarraycopy:
			has_array= has_array or resaac.has(resultarray[0])
		#if !resultarrayarraycopy.has(resultarray):
		if not has_array:
			resultarrayarraycopy.append(resultarray)
	var toreturn=[tosplitcable]
	if(len(resultarrayarraycopy)>0):
		cables[tosplitcable]=resultarrayarraycopy[0]
	for resultarraynr in range(len(resultarrayarraycopy)-1):
		cables.append(resultarrayarraycopy[resultarraynr+1])
		cablesactive.append(false)
		toreturn.append(len(cables)-1)
	generator_update()
	#var results=[]
#	for elementnr in range(len(resultarray)):
#		var new=true
#		for i in range(len(results)):
#			if resultarray[elementnr][2]==results[i]:
#				new=false
#		if(new):
#			results.append(resultarray[elementnr][2])
#			resultarrayarray.append([])
#		resultarrayarray[results.find(resultarray[elementnr][2])].append(resultarray[elementnr])
#	var toreturn=[tosplitcable]
#	if(len(resultarrayarray)==2):
#		var j=len(cables[tosplitcable])-1
#		var cablesappendix=[]
#		for i in range(len(cables[tosplitcable])):
#			for each in resultarrayarray[1]:
#				if cables[tosplitcable][j-i][0]==each[0] and cables[tosplitcable][j-i][1]==each[1]:
#					cablesappendix.append(cables[tosplitcable][j-i])
#					cables[tosplitcable].remove(j-i)
#					break
		
#		cables.append(cablesappendix)
#		cablesactive.append(false)
#		toreturn.append(len(cables)-1)
#	if(len(resultarrayarray)==3):
#		var j=len(cables[tosplitcable])-1
#		var cablesappendix=[]
#		for i in cables[tosplitcable]:
#			for each in resultarrayarray[2]:
#				if cables[tosplitcable][j-i][0]==each[0] and cables[tosplitcable][j-i][1]==each[1]:
#					cablesappendix.append(cables[tosplitcable][j-i])
#					cables[tosplitcable].remove(j-i)
#					break
#		cables.append(cablesappendix)
#		cablesactive.append(false)
#		toreturn.append(len(cables)-1)
#	if(len(resultarrayarray)==4):
#		var j=len(cables[tosplitcable])-1
#		var cablesappendix=[]
#		for i in cables[tosplitcable]:
#			for each in resultarrayarray[3]:
#				if cables[tosplitcable][j-i][0]==each[0] and cables[tosplitcable][j-i][1]==each[1]:
#					cablesappendix.append(cables[tosplitcable][j-i])
#					cables[tosplitcable].remove(j-i)
#					break
#		cables.append(cablesappendix)
#		cablesactive.append(false)
#		toreturn.append(len(cables)-1)
	return toreturn

func generator_update():
	for i in range(len(cablesactive)):
		cablesactive[i]=false
	for gen in generators:
		for neighbour in get_neighbours(Vector2(gen[0],gen[1])):
			var cable_temp=find_cable(neighbour.x,neighbour.y)
			if(cable_temp!=-1):
				cablesactive[cable_temp]=true

func get_neighbourspaths(checkarray):
	var foundnr=0
	for elementnr in range(len(checkarray)):
		for startnr in range(4):
			if(checkarray[elementnr][2]==-(startnr+1)):
				var neighbours=get_neighbours(Vector2(checkarray[elementnr][0],checkarray[elementnr][1]))
				for elementnr2 in range(len(checkarray)):
					for startnr2 in range(4):
						if(checkarray[elementnr2][0]==neighbours[startnr2][0] and checkarray[elementnr2][1]==neighbours[startnr2][1]):
							var nummer=checkarray[elementnr2][2]
							if(nummer<0 and nummer>-(startnr+1)):
								for elementnr3 in range(len(checkarray)):
									if checkarray[elementnr3][2]==nummer:
										checkarray[elementnr3][2]=-(startnr+1)
										foundnr+=1
							elif(nummer>=0):
								checkarray[elementnr2][2]=-(startnr+1)
								foundnr+=1
	if(foundnr>0):
		return get_neighbourspaths(checkarray)
	else:
		return checkarray
func get_neighbours_check(mappos, neighbours=[]):
	var cablenr=find_cable(mappos.x,mappos.y)
	var candidates=get_neighbours(mappos)
	for candidate in candidates:
		for segment in cables[cablenr]:
			if not neighbours.has(segment):
				if segment[0]==candidate[0] and segment[1]==candidate[1]:
					neighbours.append(segment)
					var toadd=get_neighbours_check(Vector2(candidate[0],candidate[1]),neighbours)
					for element in toadd:
						if not neighbours.has(element):
							neighbours.append(element)
	return neighbours
			#neighbous.append()

func get_neighbours(mappos):
	var outpos=[]
	if (int(mappos.x)%2)==0:
		outpos.append(mappos+Vector2(1,-1))
		outpos.append(mappos+Vector2(-1,-1))
		outpos.append(mappos+Vector2(-1,0))
		outpos.append(mappos+Vector2(1,0))
	else:
		outpos.append(mappos+Vector2(1,0))
		outpos.append(mappos+Vector2(-1,0))
		outpos.append(mappos+Vector2(-1,1))
		outpos.append(mappos+Vector2(1,1))
	return outpos

func add_cable_intern(mappos,is_orig=true):
	var xposmap=mappos.x
	var cablehere=find_cable(mappos.x,mappos.y)
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
		topright_has=not cabletopright<0
		cabletopleft=find_cable((mappos+Vector2(-1,-1)).x,(mappos+Vector2(-1,-1)).y)
		topleft_has=not cabletopleft<0
		cablebottomleft=find_cable((mappos+Vector2(-1,0)).x,(mappos+Vector2(-1,0)).y)
		bottomleft_has=not cablebottomleft<0
		cablebottomright=find_cable((mappos+Vector2(1,0)).x,(mappos+Vector2(1,0)).y)
		bottomright_has=not cablebottomright<0
	else:
		cabletopright=find_cable((mappos+Vector2(1,0)).x,(mappos+Vector2(1,0)).y)
		topright_has=not cabletopright<0
		cabletopleft=find_cable((mappos+Vector2(-1,0)).x,(mappos+Vector2(-1,0)).y)
		topleft_has=not cabletopleft<0
		cablebottomleft=find_cable((mappos+Vector2(-1,1)).x,(mappos+Vector2(-1,1)).y)
		bottomleft_has=not cablebottomleft<0
		cablebottomright=find_cable((mappos+Vector2(1,1)).x,(mappos+Vector2(1,1)).y)
		bottomright_has=not cablebottomright<0
	var currenttoset=5
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
		currenttoset=5
		if(cablebottomleft!=cabletopright):
			cabletoadd=mergecables(cabletopright,cablebottomleft)
		else:
			cabletoadd=cabletopright
	elif(not topright_has && not bottomright_has && bottomleft_has && not topleft_has):
		currenttoset=5
		cabletoadd=cablebottomleft
	elif(topright_has && not bottomright_has && not bottomleft_has && not topleft_has):
		currenttoset=5
		cabletoadd=cabletopright
	elif(not topright_has && bottomright_has && not bottomleft_has && topleft_has):
		currenttoset=4
		if(cablebottomright!=cabletopleft):
			cabletoadd=mergecables(cabletopleft,cablebottomright)
		else:
			cabletoadd=cabletopleft
	elif(not topright_has && not bottomright_has && not bottomleft_has && topleft_has):
		currenttoset=4
		cabletoadd=cabletopleft
	elif(not topright_has && bottomright_has && not bottomleft_has && not topleft_has):
		currenttoset=4
		cabletoadd=cablebottomright
	elif(not topright_has && bottomright_has && bottomleft_has && topleft_has):
		currenttoset=7
		if(cablebottomright!=cablebottomleft or cablebottomright!=cabletopleft):
			cabletoadd=mergecables(cablebottomleft,cabletopleft,cablebottomright)
		else:
			cabletoadd=cabletopleft
	elif(topright_has && not bottomright_has && bottomleft_has && topleft_has):
		currenttoset=8
		if(cabletopright!=cablebottomleft or cabletopright!=cabletopleft):
			cabletoadd=mergecables(cablebottomleft,cabletopleft,cabletopright)
		else:
			cabletoadd=cabletopleft
	elif(topright_has && bottomright_has && not bottomleft_has && topleft_has):
		currenttoset=9
		if(cabletopright!=cablebottomright or cabletopright!=cabletopleft):
			cabletoadd=mergecables(cablebottomright,cabletopleft,cabletopright)
		else:
			cabletoadd=cabletopleft
	elif(topright_has && bottomright_has && bottomleft_has && not topleft_has):
		currenttoset=6
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
	if(cabletoadd==-1 and cablehere==-1):
		cables.append([[mappos.x,mappos.y,currenttoset]])
		cablesactive.append(false)
		set_cell(mappos.x,mappos.y,41+currenttoset)
	else:
		if cablehere==-1:
			cables[cabletoadd].append([mappos.x,mappos.y,currenttoset])
		if(cablesactive[cabletoadd]):
			set_cell(mappos.x,mappos.y,8+3*currenttoset)
		else:
			set_cell(mappos.x,mappos.y,41+currenttoset)
		if(topright_has and is_orig):
			if(int(xposmap)%2)==0:
				add_cable_intern(Vector2(mappos.x+1,mappos.y-1),false)
			else:
				add_cable_intern(Vector2(mappos.x+1,mappos.y),false)
		if(bottomright_has and is_orig):
			if(int(xposmap)%2)==0:
				add_cable_intern(Vector2(mappos.x+1,mappos.y),false)
			else:
				add_cable_intern(Vector2(mappos.x+1,mappos.y+1),false)
		if(bottomleft_has and is_orig):
			if(int(xposmap)%2)==0:
				add_cable_intern(Vector2(mappos.x-1,mappos.y),false)
			else:
				add_cable_intern(Vector2(mappos.x-1,mappos.y+1),false)
		if(topleft_has and is_orig):
			if(int(xposmap)%2)==0:
				add_cable_intern(Vector2(mappos.x-1,mappos.y-1),false)
			else:
				add_cable_intern(Vector2(mappos.x-1,mappos.y),false)

func mergecables(cable1,cable2,cable3=-1,cable4=-1):
	var cablestomerge=[]
	cablestomerge.append(cable1)
	if(cable2>cable1):
		cablestomerge.append(cable2)
	else:
		cablestomerge.append(cable2)
	if(cable3!=-1 and cable3<cablestomerge[0]):
		cablestomerge.append(cable3)
	elif cable3!=-1 and len(cablestomerge)>1 and cable3!=cablestomerge[1]:
		cablestomerge.append(cable3)
	if(cable4!=-1 and cable4<cablestomerge[0]):
		cablestomerge.append(cable4)
	elif cable4!=-1 and not cablestomerge.has(cable4):
		cablestomerge.append(cable4)
	cablestomerge.sort()
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
				return int(cable)
	return -1

func _on_Timer_timeout():
	frame3=(frame3+1)%3
	frame4=(frame4+1)%3
	if(frame4%3==0):
		frame4_2=(frame4_2+1)%3
#	for animatedtilearray3num in range(len(animatedtilesarray3)):
#		for animatedtile in animatedtilesarray3[animatedtilearray3num]:
#			set_cell(animatedtile.x,animatedtile.y,animatedtiles3nums[animatedtilearray3num]+frame3)
	for cablenr in range(len(cablesactive)):
		if(cablesactive[cablenr]):
			for animatedtile in cables[cablenr]:
				var tile=8+animatedtile[2]*3+frame3
				set_cell(animatedtile[0],animatedtile[1],tile)
	for generat in range(len(generators)):
		set_cell(generators[generat][0],generators[generat][1],frame4+52)
	
	for ant in range(len(antenneG)):
		if(find_cable(antenneG[ant][0],antenneG[ant][1])!=-1 and cablesactive[find_cable(antenneG[ant][0],antenneG[ant][1])]):
			get_parent().get_node("Objekte").set_cell(antenneG[ant][0],antenneG[ant][1],frame4_2+56)
			antenneG[ant][2]=true
		else:
			get_parent().get_node("Objekte").set_cell(antenneG[ant][0],antenneG[ant][1],64)
			antenneG[ant][2]=false
	for ant in range(len(antenneR)):
		if(find_cable(antenneR[ant][0],antenneR[ant][1])!=-1 and cablesactive[find_cable(antenneR[ant][0],antenneR[ant][1])]):
			get_parent().get_node("Objekte").set_cell(antenneR[ant][0],antenneR[ant][1],frame4_2+60)
			antenneR[ant][2]=true
		else:
			get_parent().get_node("Objekte").set_cell(antenneR[ant][0],antenneR[ant][1],64)
			antenneR[ant][2]=false
	
	pass # replace with function body


func _on_Timer2_timeout():
	pass # replace with function body
