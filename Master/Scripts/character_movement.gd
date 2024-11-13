extends CharacterBody2D

const SPEED = 300.0
@onready var character_body = $"."
@onready var character_animation = $"Character Sprite"
var movement_axis = 0
var on_interact_area = false
func _ready() -> void:
	$"../Door Transition/AnimationPlayer".play("open_animation")

func _physics_process(delta: float) -> void:
	if character_body.velocity != Vector2.ZERO:
		if character_body.velocity > Vector2.ZERO:
			character_animation.flip_h = false
			character_animation.play("walking")
		else:
			character_animation.flip_h = true
			character_animation.play("walking")
	else:
		character_animation.play("idle")
	if not is_on_floor():
		velocity += get_gravity() * delta
	if movement_axis:
		velocity.x = movement_axis * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

#region Button Functions
# Left
func _on_move_left_button_button_down() -> void:
	movement_axis += -1
func _on_move_left_button_button_up() -> void:
	movement_axis = 0
# Right
func _on_move_right_button_button_down() -> void:
	movement_axis += 1
func _on_move_right_button_button_up() -> void:
	movement_axis = 0
# Interact
func _on_interact_button_pressed() -> void:
	SignalBus.interact_button_pressed.emit()
#endregion
