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
	if(self.name=="InfoButton"):
		get_parent().get_node("Info").visible=true
		pass
	if(self.name=="QuitButton"):
		get_tree().quit()
		pass
	if(self.name=="PlayButton"):
		get_tree().change_scene("res://Levels/PlayMenu.tscn")
	if(self.name=="JoinButton"):
		get_parent()._on_Join_pressed()
	if(self.name=="HostButton"):
		get_parent()._on_Host_pressed()
	if(self.name=="BackButton"):
		if get_parent().active:
			get_tree().change_scene("res://Levels/MainMenu.tscn")
	pass # replace with function body



func _on_InfoButton2_body_entered( body ):
	_on_Area2D_body_entered(body)
	pass # replace with function body


func _on_InfoButton2_body_exited( body ):
	_on_Area2D_body_exited(body)
	pass # replace with function body


func _on_QuitButton_body_entered( body ):
	_on_Area2D_body_entered(body)
	pass # replace with function body


func _on_QuitButton_body_exited( body ):
	_on_Area2D_body_exited(body)
	pass # replace with function body


func _on_PlayButton_body_entered( body ):
	_on_Area2D_body_entered(body)
	pass # replace with function body


func _on_PlayButton_body_exited( body ):
	_on_Area2D_body_exited(body)
	pass # replace with function body
