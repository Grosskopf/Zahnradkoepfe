extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (bool) var isplayerone=true
export (bool) var isactive=false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if isplayerone and isactive:
		$AnimatedSpriteGreen.visible=false
		$AnimatedSpriteRed.visible=true
	if not isplayerone and isactive:
		$AnimatedSpriteGreen.visible=true
		$AnimatedSpriteRed.visible=false
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
