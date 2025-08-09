@tool
extends Camera2D


@warning_ignore("integer_division")
@export var screen_size = Vector2(global.WINDOW_WIDTH, global.WINDOW_WIDTH/16*9)
@export var acceleration: float = 0.5
@export var player: CharacterBody2D
@export var free_mode: bool = false
var start_offset: Vector2

func _ready() -> void:
	start_offset = self.global_position
	return

func update_camera() -> void:
	if (player):
		var current_cell = ((player.global_position - start_offset) / screen_size).floor()
		self.global_position = lerp(self.global_position, start_offset + (current_cell * screen_size), acceleration)
	return

func _physics_process(_delta: float) -> void:
	if (free_mode): 
		if (player): 
			self.global_position = lerp(self.global_position, Vector2(player.global_position.x - (self.screen_size.x/2), player.global_position.y +  - (self.screen_size.y/2)), acceleration);
		return
	update_camera()
	return
