extends Panel

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


func _on_Button_exit_pressed():
	self.visible=false
	$Label.text="Welcome back, you know the deal"
	pass # replace with function body


func _on_Button2_pressed():	
	var paid=true
	if(get_tree().is_network_server()):
		if(global.resources[0]>8):
			global.resources[0]-=8
		else:
			paid=false
	else:
		if(global.resources[1]>8):
			global.resources[1]-=8
		else:
			paid=false
	if paid:
		$Label.text="Very well, some cable it shall be, here you go"
		if(get_tree().is_network_server()):
			global.inventory[0][0]+=1
		else:
			global.inventory[1][0]+=1
	else:
		$Label.text="How come you can't bring up even the tiniest amount of resources?"
	pass # replace with function body


func _on_Button3_pressed():
	var paid=true
	if(get_tree().is_network_server()):
		if(global.resources[0]>50):
			global.resources[0]-=50
		else:
			paid=false
	else:
		if(global.resources[1]>50):
			global.resources[1]-=50
		else:
			paid=false
	if paid:
		$Label.text="Thank you, here you go, a good solid Generator for you"
		if(get_tree().is_network_server()):
			global.inventory[0][1]+=1
		else:
			global.inventory[1][1]+=1
	else:
		$Label.text="I'm sorry, I absolutely can't give you a discount, I only buy highest quality Generators"
	



func _on_Button4_pressed():
	var paid=true
	if(get_tree().is_network_server()):
		if(global.resources[0]>100):
			global.resources[0]-=100
		else:
			paid=false
	else:
		if(global.resources[1]>100):
			global.resources[1]-=100
		else:
			paid=false
	if paid:
		$Label.text="Oh you made it, here you go, be carefull with the spiky antennas"
		if(get_tree().is_network_server()):
			global.inventory[0][2]+=1
		else:
			global.inventory[1][2]+=1
	else:
		$Label.text="This is allready as low as i can go pricewise, it's impossible to make any changes to that"
	pass # replace with function body
