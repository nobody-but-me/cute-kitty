extends CharacterBody2D

const ACCELERATION: float = .2
const FRICTION: float = .04
const GRAVITY: float = 1000.

var JUMP_FORCE: float = 250.
var SPEED: float = 100.

func ready() -> void:
	return

func move() -> void:
	var direction = Input.get_axis("a", "d")
	
	if (direction > .5): $sprite.flip_h = false
	elif (direction < -.5): $sprite.flip_h = true
	
	if (direction != 0): 
		self.velocity.x = lerp(self.velocity.x, direction * SPEED, ACCELERATION); 
		if (self.is_on_floor()): $animation_player.play("walk")
	else: 
		self.velocity.x = lerp(self.velocity.x, .0, FRICTION); 
		if (self.is_on_floor()): $animation_player.play("idle")
	return

func _process(_delta: float) -> void:
	move()
	self.move_and_slide()
	self.velocity.y += GRAVITY * _delta
	if (self.is_on_floor() || $jump_buffer.is_colliding()):
		if (Input.is_action_pressed("jump")): self.velocity.y = -JUMP_FORCE; 
	else:
		if (Input.is_action_just_released("jump") || self.is_on_ceiling()): velocity.y *= 0.5
		
	if (!self.is_on_floor()): $animation_player.play("jump")
	return
