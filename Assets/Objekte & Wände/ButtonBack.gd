extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_body_entered( body ):
	$AnimatedSprite.frame=1
	$Timer.start()
	pass # replace with function body


func _on_Area2D_body_exited( body ):
	$AnimatedSprite.frame=0
	$Timer.stop()
	pass # replace with function body


func _on_Timer_timeout():
	#TODO back
	pass # replace with function body
