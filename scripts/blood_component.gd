extends Node2D

@export var max_blood_amount: int = 150
@export var organs: bool = true

const tile_blood := preload("res://scenes/tile_blood.tscn");
const blood := preload("res://scenes/blood.tscn");

var tile_blood_path: String = '/root/main/blood_viewport/viewport'
var blood_path: String = '/root/main/'

var random = RandomNumberGenerator.new()
var count: int = 0;
var colour: Color;

func add_organ(texture):
	var organ = preload("res://scenes/organs.tscn").instantiate()
	organ.global_position = get_node("/root/main/kitty").get_global_position()
	organ.global_position.y -= 10
	organ.tex = texture
	
	get_node("/root/main/").call_deferred("add_child", organ)
	return organ

func explode() -> void:
	randomize()
	random.randomize()
	colour = Color(randf_range(0.0, 150.0), 0.0, 0.0, randf_range(10.0, 255.0))
	
	for i in range(0, max_blood_amount, 1):
		var tb = tile_blood.instantiate()
		var b = blood.instantiate()
		
		tb.get_node("Sprite2D").modulate = colour
		b.get_node("Sprite2D").modulate = colour
		
		tb.blood = b;
		
		get_node(tile_blood_path).call_deferred("add_child", tb)
		get_tree().current_scene.call_deferred("add_child", b)
		tb.name = "blood_particle" + str(count)
		b.name  = "blood_particle" + str(count)
		
		b.horizontal_speed = random.randf_range(-1, 1)
		b.vertical_speed = random.randf_range(-2, -0.5)
		
		var init_position: Vector2 = get_node("/root/main/kitty").get_global_position()
		init_position.y -= 10
		 
		tb.global_position = init_position
		b.global_position = init_position
		count += 1;
	# TODO: oh my fucking god
	if (organs):
		for i in range(0, 8, 1):
			add_organ(preload("res://sprites/organs/bone.png"))
		add_organ(preload("res://sprites/organs/stomach.png"))
		add_organ(preload("res://sprites/organs/trachea.png"))
		add_organ(preload("res://sprites/organs/spleen.png"))
		add_organ(preload("res://sprites/organs/skull.png"))
		add_organ(preload("res://sprites/organs/lungs.png"))
		add_organ(preload("res://sprites/organs/liver.png"))
		add_organ(preload("res://sprites/organs/heart.png"))
		add_organ(preload("res://sprites/organs/ribs.png"))
			
		var brain = add_organ(preload("res://sprites/organs/brain.png"))
		get_tree().current_scene.get_node("main_camera").free_mode = true
		get_tree().current_scene.get_node("main_camera").player = brain
	return

func _ready() -> void:
	explode()
	return
