extends Control

var play_button_pressed = false

func _ready() -> void:
	$"Door Transition/AnimationPlayer".play("open_animation")

# Signals
func _on_play_button_pressed() -> void:
	play_button_pressed = true
	$"Door Transition/AnimationPlayer".play("close_aniamtion")
	
func _on_settings_button_pressed() -> void:
	print("Opened Settings!")

func _on_exit_button_pressed() -> void:
	print("Exited!")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if play_button_pressed:
		get_tree().change_scene_to_file("res://Master/Scenes/newsite_map.tscn")
