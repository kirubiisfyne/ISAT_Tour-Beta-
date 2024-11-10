extends Sprite
func _ready():
	if Global.gender == "Male":
		texture = preload()
	elif Global.gender == "Female":
		texture = preload()
	else:
		texture = preload()  
