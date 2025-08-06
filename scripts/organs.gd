extends CharacterBody2D

@export var tex: Texture2D

var gravity: float = 250.0

func _ready() -> void:
	$start_die_timer.start()
	randomize()
	velocity = Vector2(randf_range(-50.0, 50.0), randf_range(250.0, 550.0))
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
	return

func _on_start_die_timer_timeout() -> void:
	$animation_player.play("modulate")
	$queue_free_timer.start()
	return

func _on_queue_free_timer_timeout() -> void:
	self.queue_free()
	return
