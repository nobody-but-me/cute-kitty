extends Node

const WINDOW_WIDTH: int = 224;
var GAME_STATE: String = "GAME";

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("restart") && GAME_STATE == "DEAD"): 
		var player = preload("res://scenes/player/kitty.tscn").instantiate()
		get_tree().current_scene.get_node("player_group").add_child(player)
		get_tree().current_scene.get_node("main_camera").free_mode = false;
		get_tree().current_scene.get_node("main_camera").player = player;
		get_tree().current_scene.get_node("CanvasLayer").queue_free()
	elif (Input.is_action_just_pressed("restart") && GAME_STATE == "WIN"): get_tree().reload_current_scene()
	if (Input.is_action_just_pressed("ui_cancel")): get_tree().quit()
	return
