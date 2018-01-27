extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#export (bool) var has_plakat=true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#if not has_plakat:
	#	$Sprite.visible=false
	pass



func _on_Hideobj_body_entered( body ):
	self.region_rect=Rect2(321,0,321,338)
	pass # replace with function body


func _on_Hideobj_body_exited( body ):
	self.region_rect=Rect2(0,0,321,338)
	pass # replace with function body
