extends Node


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("restart")): get_tree().reload_current_scene()
	if (Input.is_action_just_pressed("ui_cancel")): get_tree().quit()
	return
