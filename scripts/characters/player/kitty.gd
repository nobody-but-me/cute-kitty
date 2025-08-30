extends CharacterBody2D

const ACCELERATION: float = .2
const GRAVITY: float = 1000.
const FRICTION: float = .04

const JUMP_HEIGHT: int = 40

var last_floor: bool = false
var coyote: bool = false
var jumping: bool = false

var jump_force: float = sqrt(2 * GRAVITY * JUMP_HEIGHT)
var speed: float = 100.
var state: String = 'idle'

func _ready() -> void:
	self.global_position = get_tree().current_scene.get_node("player_init_position").global_position

func kill() -> void:
	var blood_component = preload("res://scenes/components/blood_component.tscn").instantiate()
	blood_component.global_position = self.global_position
	blood_component.max_blood_amount = 50
	blood_component.organs = true
	
	get_tree().current_scene.add_child(blood_component)
	self.queue_free()
	return

func update_animation() -> void:
	match state:
		'idle':    $animation_player.play('idle');
		'walking': $animation_player.play('walk');
		'jumping': $animation_player.play('jump');
		'resting': $animation_player.play('rest');
		_:
			return
	return

func move() -> void:
	var direction = Input.get_axis("a", "d")
	
	if (direction > .5): $sprite.flip_h = false; $jump_buffer_sprite.flip_h = false
	elif (direction < -.5): $sprite.flip_h = true; $jump_buffer_sprite.flip_h = true
	
	if (direction != 0): 
		self.velocity.x = lerp(self.velocity.x, direction * speed, ACCELERATION); 
		if (self.is_on_floor() && state != 'resting'): state = 'walking'
	else: 
		self.velocity.x = lerp(self.velocity.x, .0, FRICTION); 
		if (self.is_on_floor() && state != 'resting'): state = 'idle'
	return

func _physics_process(_delta: float) -> void:
	move()
	last_floor = is_on_floor()
	if (last_floor): jumping = false
	self.move_and_slide()
	self.velocity.y += GRAVITY * _delta
	if (self.is_on_floor() || $jump_buffer.is_colliding() || coyote):
		if (Input.is_action_just_pressed("jump")): self.velocity.y = -jump_force; jumping = true
	
	if (!self.is_on_floor()): 
		if (Input.is_action_just_released("jump") || self.is_on_ceiling()): 
			velocity.y *= 0.5;
		if (last_floor && !jumping):
			coyote = true
			$coyote_timer.start()
			
		state = 'jumping'
		
	if ((!self.is_on_floor() && $jump_buffer.is_colliding()) || coyote): $jump_buffer_sprite.visible = true
	else: $jump_buffer_sprite.visible = false
	
	update_animation();
	return

func _input(_event: InputEvent) -> void:
	if (_event is InputEventKey):
		# TODO: the worst logic I have ever seen.
		if (_event.pressed): 
			$resting_timer.stop()
			state = 'idle'
		else: $resting_timer.start()
	return

func _on_timer_timeout() -> void:
	coyote = false
	return

func _on_resting_timer_timeout() -> void:
	if (self.is_on_floor()):
		if (state == 'idle'): state = 'resting'
	return

func _on_danger_area_body_entered(_body: Node2D) -> void:
	if (_body.is_in_group("dangerous")): kill()
	return

func _on_danger_area_area_entered(_area: Area2D) -> void:
	if (_area.is_in_group("cat_pillow")): 
		var sprite: Sprite2D = Sprite2D.new(); 
		sprite.texture = preload("res://sprites/kitty/bigodin/kitty-resting.png");
		sprite.z_index = 5
		sprite.global_position = Vector2(_area.get_node("player_position").global_position.x, _area.get_node("player_position").global_position.y - 11);
		#sprite.flip_h = _area.player_side
		sprite.flip_h = $sprite.flip_h
		get_tree().current_scene.get_node("player_group").add_child(sprite)
		#global.GAME_STATE = "WIN"
		_area.change_scene()
		self.queue_free()
	return
