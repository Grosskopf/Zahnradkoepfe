extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var animatedtiles8=[]
var frame3=0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	animatedtiles8=get_used_cells_by_id(8)
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	frame3=(frame3+1)%3
	for animatedtile8 in animatedtiles8:
		set_cell(animatedtile8.x,animatedtile8.y,8+frame3)
	pass # replace with function body
