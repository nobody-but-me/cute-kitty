extends Area2D

@onready var blood: Area2D;

var random: float = 0.0;

func _ready() -> void:
	random = randf_range(0.1, 1.5)
	$death_timer.wait_time = random
	
	$death_timer.start()
	self.visible = false
	return

func _physics_process(_delta: float) -> void:
	if (blood != null):
		if (blood.get_overlapping_bodies().is_empty()): self.visible = false;
		else: self.visible = true;
		self.global_position = blood.global_position
	
	return

func _on_death_timer_timeout() -> void:
	blood.queue_free()
	self.queue_free()
	return
