extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var npccaller=[1,1,2,3,5,8,13,21,34,55]
var numbercalled=[0,0]
var calling=[0.0,0.0]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func spawn(player):
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
