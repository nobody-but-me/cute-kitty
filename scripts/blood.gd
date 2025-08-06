extends Area2D

const VERTICAL_SPEED_INTENSITY: float = 0.03
const MAX_VERTICAL_SPEED: float = 5.0

const MIN_WEIGHT: float = 0.01
const MAX_WEIGHT: float = 0.1

@export var horizontal_weight: float = 0.01;
@export var horizontal_speed:  float = 2.0;

var vertical_speed: float = 0.0;

func _physics_process(_delta: float) -> void:
	if (get_overlapping_bodies().is_empty()):
		# TODO: magic numbers
		horizontal_weight = MIN_WEIGHT
		if (vertical_speed < MAX_VERTICAL_SPEED): vertical_speed += VERTICAL_SPEED_INTENSITY
		else: 
			horizontal_weight = MAX_WEIGHT
			vertical_speed = sin(_delta)
	horizontal_speed = lerp(horizontal_speed, 0.0, horizontal_weight)
	position += Vector2(horizontal_speed, vertical_speed)
	return
