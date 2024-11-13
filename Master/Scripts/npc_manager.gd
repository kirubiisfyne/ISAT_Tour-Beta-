extends Node2D

@export var npc_provide_quiz = true
@export var level_key : int
@export var dialog_key : String
@export var json_file_path : String
@export var character_root : Node2D
@export var controls_root : CanvasLayer
@onready var npc_root = $"."
@onready var quiz_root = $"Quiz Main"
@onready var dialog_root = $"Dialog Main"
@onready var dialog_name = $"Dialog Main/Dialog Box/VBoxContainer/Label"
@onready var dialog_label = $"Dialog Main/Dialog Box/VBoxContainer/Dialog"
var area_active = false
var in_progress = false
var dialog_dictionary = {}
var dialog_lines = []
func _ready() -> void:
	dialog_dictionary = _load_json_file(json_file_path)
	SignalBus.interact_button_pressed.connect(_trigger_dialog)
	SignalBus.quiz_finnished.connect(_disable_quiz)
# Functions
func _trigger_dialog():
	print("Interact pressed!")
	if area_active:
		run_dialog(dialog_key)
func _load_json_file(file_path : String):
	if FileAccess.file_exists(file_path):
		var raw_json_file = FileAccess.open(file_path, FileAccess.READ)
		var json_parsed = JSON.parse_string(raw_json_file.get_as_text())
		if json_parsed is Dictionary:
			print("json_parsed is dictionary")
			raw_json_file.close()
			return json_parsed
func _show_text():
	dialog_label.text = dialog_lines.pop_front()
func _next_line():
	if dialog_lines.size() > 0:
		_show_text()
	else:
		finnish()
func finnish():
	dialog_label.text = ""
	dialog_name.text = ""
	in_progress = false
	dialog_root.visible = false
	_set_visibility(false)
func _set_visibility(visible : bool):
	if npc_provide_quiz:
		quiz_root.visible = !visible
		character_root.visible = visible
		npc_root.visible = visible
		controls_root.visible = visible
func run_dialog(dialog_key):
	if in_progress:
		_next_line()
	else:
		dialog_root.visible = true
		dialog_name.text = dialog_key
		dialog_lines = dialog_dictionary[dialog_key]
		_show_text()
func _disable_quiz():
	SignalBus.levels_array[level_key + 1] = true
	print(SignalBus.levels_array)
	_set_visibility(true)
#region Signals
func _on_dialog_area_trigger_area_entered(area: Area2D) -> void:
	area_active = true
func _on_dialog_area_trigger_area_exited(area: Area2D) -> void:
	area_active = false
func _on_next_button_pressed() -> void:
	_next_line()
#endregion
