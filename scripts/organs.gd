extends CharacterBody2D

@export var tex: Texture2D

var gravity: float = 250.0
var bone: bool = false

func _ready() -> void:
	$start_die_timer.start()
	randomize()
	velocity = Vector2(randf_range(-50.0, 50.0), randf_range(250.0, 550.0))
	self.rotation_degrees = randf_range(0.0, 360.0)
	$sprite.texture = tex;
	
	if ($sprite.texture == preload("res://sprites/organs/bone.png") || $sprite.texture == preload("res://sprites/organs/skull.png") || $sprite.texture == preload("res://sprites/organs/ribs.png")):
		bone = true
	if ($sprite.texture == preload("res://sprites/organs/heart.png")):
		$blood_timer.start()
	return

func add_blood() -> void:
	$blood_component.explode()
	return

func _physics_process(_delta: float) -> void:
	var collision_info = move_and_collide(velocity * _delta)
	if (!self.is_on_floor()): self.velocity.y += gravity * _delta
	
	if (collision_info):
		velocity = velocity.bounce(collision_info.get_normal())
		velocity.x *= 0.5
		velocity.y *= 0.5
	if (velocity.x > 3.0):
		self.rotation_degrees += 1 * (velocity.x / 10)
	return

func _on_start_die_timer_timeout() -> void:
	$animation_player.play("modulate")
	$queue_free_timer.start()
	return

func _on_queue_free_timer_timeout() -> void:
	self.queue_free()
	return

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if (bone == false): $squish.play("squish"); add_blood()
	return

func _on_blood_timer_timeout() -> void:
	$blood_timer.wait_time += 0.2
	$squish.play("squish")
	add_blood()
	return
