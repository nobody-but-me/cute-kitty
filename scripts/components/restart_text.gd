extends RichTextLabel

const ACCELERATION = 0.03
const texts: Array = [
	"And you died... Once again",
	"Maybe it would be easier if you at least tried.",
	"Let's try not to jump right in the spines next time...",
	"Organs, organs and more organs...",
	"Poor little kitty!",
	"Blood explosion!",
	"It's hard for you to press the jump button, so, please, try to press 'R' now" ,
	"...",
	"If I were your mother, I'd feel embarresed.",
	"Are you already crying?",
	"Did you learn how to use a computer today?",
	"Cute kitty's who lost its brain, but it seems like you are the brainless here.",
	"Retardation's a problem in mental development that result in a lack of intelligence...",
	"O.k., let's play seriously from now",
	"Are you fucking stupid?",
	"Maybe games are not for you, buddy",
	"Your mommy was right: go get a job!",
	"Next time, get your hands off your dirty bootyhole and use them to play the game.",
	"Oh boy, that's why abortion exists",
	"The fact you were dropped as a baby doesn't give you the right to drop the kitty.",
	"Even Miranda would be able to beat this game.",
	"Are you paralyzed? Because it seems like you are",
]
var selected_text: int = 0;

var random = RandomNumberGenerator.new()

func _ready() -> void:
	randomize()
	random.randomize()
	@warning_ignore("narrowing_conversion")
	selected_text = random.randf_range(0, texts.size());
	self.global_position.x = randf_range(-global.WINDOW_WIDTH, 0.0 - self.size.x);
	@warning_ignore("integer_division")
	self.global_position.y = randf_range((global.WINDOW_WIDTH/16*9) * -1, 0.0 - self.size.y);
	self.text = "[center]" + texts[selected_text] + "\n[wave amp=50]Restart with 'R'"
	$shadow.text = self.text
	return

func _process(_delta: float) -> void:
	@warning_ignore("integer_division")
	self.global_position.x = lerp(self.global_position.x, (global.WINDOW_WIDTH/2) - self.size.x/2.5, ACCELERATION);
	@warning_ignore("integer_division")
	self.global_position.y = lerp(self.global_position.y, float(((global.WINDOW_WIDTH/16*9)/2) - self.size.y / 4), ACCELERATION);
	return
