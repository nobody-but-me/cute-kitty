extends RichTextLabel

const ACCELERATION = 0.01
const texts: Array = [
	"And you died... Once again",
	"Perhaps it would be easier if you even tried.",
	"Let's try the next: don't jump into spines!",
	"Organs, organs and more organs",
	"Poor little kitty!",
	"Explosion of blood!",
]
var selected_text: int = 0;

func _ready() -> void:
	randomize()
	self.global_position.x = randf_range(-global.WINDOW_WIDTH, 0.0 - self.size.x);
	@warning_ignore("integer_division")
	self.global_position.y = randf_range((global.WINDOW_WIDTH/16*9) * -1, 0.0 - self.size.y);
	@warning_ignore("narrowing_conversion")
	selected_text = randf_range(0, texts.size());
	self.text = "[center]" + texts[selected_text] + "\n[wave amp=50]Restart with 'R'"
	$shadow.text = self.text
	return

func _process(_delta: float) -> void:
	@warning_ignore("integer_division")
	self.global_position.x = lerp(self.global_position.x, (global.WINDOW_WIDTH/2) - self.size.x/2.5, ACCELERATION);
	@warning_ignore("integer_division")
	self.global_position.y = lerp(self.global_position.y, ((global.WINDOW_WIDTH/16*9)/2) - self.size.y/4, ACCELERATION);
	return
