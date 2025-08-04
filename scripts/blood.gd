extends Area2D

const VERTICAL_SPEED_INTENSITY: float = 0.07 
const MAX_VERTICAL_SPEED: float = 2.0

@export var horizontal_weight: float = 0.001;
@export var horizontal_speed:  float = 1;

var vertical_speed: float = 0.0;

func _physics_process(_delta: float) -> void:
	if (get_overlapping_bodies().is_empty()):
		# TODO: magic numbers
		horizontal_weight = 0.01
		if (vertical_speed < MAX_VERTICAL_SPEED): vertical_speed += VERTICAL_SPEED_INTENSITY
		else: 
			horizontal_weight = 0.1
			vertical_speed = sin(_delta)
	horizontal_speed = lerp(horizontal_speed, 0.0, horizontal_weight)
	position += Vector2(horizontal_speed, vertical_speed)
	return
