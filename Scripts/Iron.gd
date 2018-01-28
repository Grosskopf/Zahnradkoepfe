extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var amount=100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var bodies=get_overlapping_bodies()
	for body in bodies:
		if(body.get_groups().has("NPC")):
			amount-=delta
	amount-=delta
	$AnimatedSprite.frame=int((100-amount)/25)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
