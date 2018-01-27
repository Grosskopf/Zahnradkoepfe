extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var frame_counter=0
var counter=0
var on=true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	counter+=delta*2
	if on:
		var temporary=counter+frame_counter
		print(temporary)
		frame_counter=((int(temporary))%3)*64
		print(frame_counter)
		region_rect=Rect2(frame_counter,0,64,48)
	else:
		region_rect=Rect2(192,0,64,48)
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
