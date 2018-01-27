extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (bool) var isactive=false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if isactive:
		$AnimatedSprite.visible=true
	else:
		$AnimatedSprite.visible=false
	pass
slave func movement_added(movement):
	move_and_collide(movement)
func go(movement):
	
	move_and_collide(movement)
	
	rpc_unreliable("movement_added",movement)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
