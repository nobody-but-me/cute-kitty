extends RichTextLabel

const ACCELERATION = 0.2

var target;

func _ready() -> void:
	if (target == null): return
	return

func _process(_delta: float) -> void:
	if (target):
		self.global_position.x = lerp(self.global_position.x, target.global_position.x - (self.size.x / 2), ACCELERATION) + 1.5;
		self.global_position.y = (lerp(self.global_position.y, target.global_position.y - (self.size.y / 2), ACCELERATION));
		
		if (target.velocity.x > 3.0 && target.velocity.y > 3.0):
			self.rotation_degrees += 1 * (target.velocity.x / 100)
		elif (target.velocity.x < 1.0 && target.velocity.y < 1.0):
			self.rotation_degrees = lerp(self.rotation_degrees, 0.0, 0.03)
	return
