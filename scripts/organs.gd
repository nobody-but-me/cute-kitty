extends CharacterBody2D

@export var tex: Texture2D

var gravity: float = 150.0
var energy: float = 10.0

func _ready() -> void:
	randomize()
	velocity = Vector2(randf_range(-50.0, 50.0), randf_range(-50.0, 50.0))
	self.rotation_degrees = randf_range(0.0, 360.0)
	$sprite.texture = tex;
	return

func _physics_process(_delta: float) -> void:
	var collision_info = move_and_collide(velocity * _delta)
	self.velocity.y += gravity * _delta
	
	if (collision_info):
		velocity = velocity.bounce(collision_info.get_normal())
		velocity.x *= 0.5
		velocity.y *= 0.5
	#if (self.is_on_floor() || self.is_on_ceiling()):
		#gravity *= 0.5
	return
