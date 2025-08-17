extends Area2D


@export var player_side: bool = false
@export var scene: PackedScene;

func change_scene() -> void:
	scene_changer.change_scene(scene);
	return
