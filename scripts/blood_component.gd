extends Node2D

const tile_blood := preload("res://scenes/tile_blood.tscn");
const blood := preload("res://scenes/blood.tscn");

var tile_blood_path: String = '/root/main/blood_viewport/viewport'
var blood_path: String = '/root/main/'

var random = RandomNumberGenerator.new()
var count: int = 0;
var colour: Color;

func _ready() -> void:
	random.randomize()
	
	randomize()
	colour = Color(randf_range(0.0, 150.0), 0.0, 0.0, randf_range(50.0, 255.0))
	return

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("mb_left")):
		for i in range(0, 125, 1):
			var tb = tile_blood.instantiate()
			var b = blood.instantiate()
			
			tb.get_node("Sprite2D").modulate = colour
			b.get_node("Sprite2D").modulate = colour
			
			tb.blood = b;
			
			get_node(tile_blood_path).add_child(tb)
			get_node(blood_path).add_child(b)
			tb.name = "blood_particle" + str(count)
			b.name  = "blood_particle" + str(count)
			
			b.horizontal_speed = random.randf_range(-1, 1)
			b.vertical_speed = random.randf_range(-1, 0.5)
			
			var init_position: Vector2 = get_node("/root/main/kitty").get_global_position()
			init_position.y -= 10
			 
			tb.global_position = init_position
			b.global_position = init_position
			count += 1;
	return
