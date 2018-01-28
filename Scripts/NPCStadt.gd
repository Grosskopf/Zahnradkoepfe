extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var npcscene = load("res://Assets/Characters/NPC.tscn")

var npccaller=[1,1,2,3,5,8,13,21,34,55]
var numbercalled=[0,0]
var calling=[0.0,0.0]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	pass
func spawn(player):
	var npc=npcscene.instance()
	var positions=[]
	for object in get_parent().get_children():
		if object.has_group("SpawnPosition"):
			positions.append(object.position)
	if(len(positions)>0):
		npc.pos=positions[randi()%len(positions)]
		get_parent().add_child(npc)
	pass
func _process(delta):
	var bodenObjekte=get_parent().get_parent().get_node("BodenObjekte")
	if(numbercalled[0]<10 and calling[0]>npccaller[numbercalled[0]]):
		spawn(0)
		calling[0]-=npccaller[numbercalled[0]]
		numbercalled[0]+=1
	if(numbercalled[0]<10 and calling[1]>npccaller[numbercalled[1]]):
		spawn(0)
		calling[1]-=npccaller[numbercalled[1]]
		numbercalled[1]+=1
		
	for rote_antenne in bodenObjekte.antenneR:
		if(rote_antenne[2]):
			var antpos=bodenObjekte.map_to_world(Vector2(rote_antenne[0],rote_antenne[1]))
			var distAnt=antpos.distance_to(position)
			if(distAnt<1000):
				calling[0]+=(1000-distAnt)*delta/10000
	for gruene_antenne in bodenObjekte.antenneG:
		if(gruene_antenne[2]):
			var antpos=bodenObjekte.map_to_world(Vector2(gruene_antenne[0],gruene_antenne[1]))
			var distAnt=antpos.distance_to(position)
			if(distAnt<1000):
				calling[1]+=(1000-distAnt)*delta/10000
	pass

#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
