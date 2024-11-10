extends Control
func _on_male_button_pressed():
	Global.gender = "Male"
	print("You Selected Male") 
func _on_female_button_pressed():
	Global.gender = "Female"
	print("You Selected Female")  
