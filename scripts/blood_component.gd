extends Node2D

const tile_blood := preload("res://scenes/tile_blood.tscn");
const blood := preload("res://scenes/blood.tscn");

var tile_blood_path: String = '/root/main/blood_viewport/viewport'
var blood_path: String = '/root/main/'

var random = RandomNumberGenerator.new()
var count: int = 0;
var colour: Color;

func _ready() -> void:
	return

func add_organ(texture) -> void:
	var organ = preload("res://scenes/organs.tscn").instantiate()
	organ.global_position = get_node("/root/main/kitty").get_global_position()
	organ.global_position.y -= 10
	organ.tex = texture
	
	get_node("/root/main/").add_child(organ)
	return

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("mb_left")):
		randomize()
		random.randomize()
		colour = Color(randf_range(0.0, 150.0), 0.0, 0.0, randf_range(50.0, 255.0))
		
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
		for i in range(0, 8, 1):
			add_organ(preload("res://sprites/organs/bone.png"))
		add_organ(preload("res://sprites/organs/stomach.png"))
		add_organ(preload("res://sprites/organs/trachea.png"))
		add_organ(preload("res://sprites/organs/spleen.png"))
		add_organ(preload("res://sprites/organs/brain.png"))
		add_organ(preload("res://sprites/organs/skull.png"))
		add_organ(preload("res://sprites/organs/lungs.png"))
		add_organ(preload("res://sprites/organs/liver.png"))
		add_organ(preload("res://sprites/organs/heart.png"))
		add_organ(preload("res://sprites/organs/ribs.png"))
	return
