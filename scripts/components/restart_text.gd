extends Label

const ACCELERATION = 0.03
const texts: Array = [
	"And you died... Once again",
	"Maybe it would be easier if you at least tried.",
	"Let's try not to jump right in the spines next time...",
	"Organs, organs and more organs...",
	"Poor little kitty! See what you did to it! What a monster!",
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
	"Your mommy was right: you are a failure.",
	"Next time, get your fingers out of your dirty bootyhole and use them to play the game.",
	"Oh boy, that's why abortion exists",
	"The fact you were dropped as a baby doesn't give you the right to drop the kitty.",
	"Even Miranda would be able to beat this game.",
	"Are you paralyzed? Because it seems like you are",
	"Don't you get tired of dying?",
]
var random = RandomNumberGenerator.new()
var selected_text: int = 0;

func _ready() -> void:
	randomize()
	random.randomize()
	@warning_ignore("narrowing_conversion")
	selected_text = random.randf_range(0, texts.size());
	
	var txt: String = texts[selected_text] + "\nRestart with 'R'"
	self.text = txt
	return

func _on_dead_timer_timeout() -> void:
	global.GAME_STATE = "DEAD"
	return
