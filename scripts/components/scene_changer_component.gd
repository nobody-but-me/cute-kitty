extends CanvasLayer


func _ready() -> void:
	$background/animation_player.play("scene_changer")
	get_tree().paused = true
	await $background/animation_player.animation_finished
	get_tree().paused = false
	return

func change_scene(scene: PackedScene) -> void:
	$background/animation_player.play_backwards("scene_changer")
	get_tree().paused = true
	await $background/animation_player.animation_finished
	get_tree().call_deferred("change_scene_to_packed", scene)
	await get_tree().scene_changed
	$background/animation_player.play("scene_changer")
	await $background/animation_player.animation_finished
	get_tree().paused = false
	return
