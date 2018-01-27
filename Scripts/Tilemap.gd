extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var animatedtilesarray3=[]
var animatedtiles3nums=[8,11,14,17,20,23,26,29,32,35,38]
var frame3=0

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


func _on_Timer_timeout():
	frame3=(frame3+1)%3
	for animatedtilearray3num in range(len(animatedtilesarray3)):
		for animatedtile in animatedtilesarray3[animatedtilearray3num]:
			set_cell(animatedtile.x,animatedtile.y,animatedtiles3nums[animatedtilearray3num]+frame3)
	pass # replace with function body
