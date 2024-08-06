extends CharacterBody2D
class_name Player

@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent


func _process(delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	var direction: Vector2 = movement_vector.normalized()
	
	velocity_component.accelerate_in_direction(direction)
	
	velocity_component.move(self)
	
	var move_sign: int = sign(movement_vector.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func get_movement_vector() -> Vector2:
	var x_movement: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y_movement: float = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return Vector2(x_movement, y_movement)
