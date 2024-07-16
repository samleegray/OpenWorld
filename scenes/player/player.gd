extends CharacterBody2D
class_name Player

@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent

var did_dash = false
var number_colliding_bodies = 0
var base_speed = 0

func _ready():
	base_speed = velocity_component.max_speed


func dash(direction: Vector2):
	if did_dash:
		return
	did_dash = true
	print("dashing")
	velocity_component.dash_in_direction(direction)


func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	
	if Input.get_action_strength("dash") > 0 and not did_dash:
		dash(direction)
	else:
		velocity_component.accelerate_in_direction(direction)
	
	velocity_component.move(self)
		
	var move_sign = sign(movement_vector.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)

func get_movement_vector():
	var x_movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y_movement = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return Vector2(x_movement, y_movement)

