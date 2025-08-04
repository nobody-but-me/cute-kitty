@tool
extends SubViewportContainer


func _ready() -> void:
	$viewport.size = self.size
	return
