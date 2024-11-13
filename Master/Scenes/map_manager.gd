extends Control

@onready var transition = $"Door Transition/AnimationPlayer"
@onready var selected_level = ""
@onready var level_buttons_array = [
	$"Button Container/Button_Guard",
	$"Button Container/Button_CompDept",
	$"Button Container/Button_Biology",
	$"Button Container/Button_Research Hub",
	$"Button Container/Button_Registrar",
	$"Button Container/Button_Science Building",
	$"Button Container/Button_CEA"
]

func _ready() -> void:
	_unlock_buttons()
	transition.play("open_animation")
# Functions

func _unlock_buttons():
	var index = 0
	for i in range(level_buttons_array.size()):
		if SignalBus.levels_array[index]:
			var active_button = level_buttons_array[index]
			if active_button:
				active_button.disabled = false
				index += 1
		else:
			print("Map Locked!")
# Signals

func _on_button_guard_pressed() -> void:
	selected_level = "res://Master/Scenes/Levels/guard_scene.tscn"
	transition.play("close_aniamtion")
	
func _on_button_comp_dept_pressed() -> void:
	selected_level = "res://Master/Scenes/Levels/compdept_scene.tscn"
	transition.play("close_aniamtion")

func _on_button_biology_pressed() -> void:
	selected_level = ""
	transition.play("close_aniamtion")

func _on_button_research_hub_pressed() -> void:
	selected_level = ""
	transition.play("close_aniamtion")

func _on_button_registrar_pressed() -> void:
	selected_level = ""
	transition.play("close_aniamtion")

func _on_button_science_building_pressed() -> void:
	selected_level = ""
	transition.play("close_aniamtion")

func _on_button_cea_pressed() -> void:
	selected_level = ""
	transition.play("close_aniamtion")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(selected_level)
