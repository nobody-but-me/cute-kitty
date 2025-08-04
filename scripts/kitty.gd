extends CharacterBody2D

const ACCELERATION: float = .2
const FRICTION: float = .04
const GRAVITY: float = 1000.

var last_floor: bool = false
var coyote: bool = false
var jumping: bool = false

var jump_force: float = 250.
var speed: float = 100.

func ready() -> void:
	return

func move() -> void:
	var direction = Input.get_axis("a", "d")
	
	if (direction > .5): $sprite.flip_h = false
	elif (direction < -.5): $sprite.flip_h = true
	
	if (direction != 0): 
		self.velocity.x = lerp(self.velocity.x, direction * speed, ACCELERATION); 
		if (self.is_on_floor()): $animation_player.play("walk")
	else: 
		self.velocity.x = lerp(self.velocity.x, .0, FRICTION); 
		if (self.is_on_floor()): $animation_player.play("idle")
	return

func _physics_process(_delta: float) -> void:
	move()
	last_floor = is_on_floor()
	if (last_floor): jumping = false
	self.move_and_slide()
	self.velocity.y += GRAVITY * _delta
	if (self.is_on_floor() || $jump_buffer.is_colliding() || coyote):
		if (Input.is_action_just_pressed("jump")): self.velocity.y = -jump_force; jumping = true
	else:
		if (Input.is_action_just_released("jump") || self.is_on_ceiling()): velocity.y *= 0.5
	
	if (!self.is_on_floor() && last_floor && !jumping):
		$animation_player.play("jump");
		coyote = true
		$coyote_timer.start()
	return

func _on_timer_timeout() -> void:
	coyote = false
	return
