@tool
extends Camera2D

@warning_ignore("integer_division")
@export var screen_size = Vector2(198, 198/16*9)
@export var player: CharacterBody2D
@export var acceleration: float = 0.5

var start_offset: Vector2

func _ready():
	start_offset = self.global_position
	return

func update_camera():
	var current_cell = ((player.global_position - start_offset) / screen_size).floor()
	self.global_position = lerp(self.global_position, start_offset + (current_cell * screen_size), acceleration)

func _physics_process(_delta: float) -> void:
	update_camera()
	return
