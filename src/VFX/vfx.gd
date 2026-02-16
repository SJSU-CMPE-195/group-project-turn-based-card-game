extends Node

var vignette
var camera
var trauma: float = 0.0
var shake_strength := 0.0
var shake_direction := Vector2.ZERO
var shake_randomness := 0.0
var rumbling: bool = false
var rumble_strength: float = 0.0
var rumble_duration: float
var r: float = 0.0
var t: float
var noise_x: FastNoiseLite
var noise_y: FastNoiseLite
var val: float = 0.0


func _ready():
	noise_x = FastNoiseLite.new()
	noise_x.noise_type = FastNoiseLite.TYPE_PERLIN
	noise_x.frequency = 0.1
	noise_x.seed = 1
	
	noise_y = FastNoiseLite.new()
	noise_y.noise_type = FastNoiseLite.TYPE_PERLIN
	noise_x.frequency = 0.1
	noise_y.seed = 2


# Called when the node enters the scene tree for the first time.

func damage_flash(duration: float = 1.0):
	print("COLOR")
	var tween = create_tween()
	var starting_color: Color = Color(0.0, 0.0, 0.0, 0.0)
	print("COLOR: ", starting_color)
	tween.tween_property(vignette.material,'shader_parameter/color', Color(1.0, 0.0, 0.0, 1.0), 0.05)
	tween.tween_property(vignette.material,'shader_parameter/color', starting_color, duration)

func stun_fx(node: Node2D, global_position: Vector2, duration: float):
	pass
	#var instance = preload("res://VFX/StunVFX.tscn").instantiate()
	#node.add_child(instance)
	#instance.global_position = global_position
	#await get_tree().create_timer(duration).timeout
	#instance.remove()

func start_shake(strength: float):
	camera = get_viewport().get_camera_2d()
	trauma = min(trauma + strength, 1.00)

func start_rumble(strength: float, duration: float):
	camera = get_viewport().get_camera_2d()
	rumbling = true
	rumble_strength = strength
	rumble_duration = duration
	r = 0

func _process(delta):
	#val += 1.0 * delta 
	if rumbling:
		if r < rumble_duration:
			r += delta
			trauma = min(trauma + rumble_strength * 2.3 * delta, 1.0)
		else:
			rumbling = false
			r = 0.0
	if trauma > 0.0:
		if t > 1000.0:
			t = 0.0
		t = (t + 100.0 * delta)
		# Primary directional offset
		var x = 1000.0 * noise_x.get_noise_1d(t)
		var y = 1000.0 * noise_y.get_noise_1d(t)
		camera.offset = Vector2(x * 0.8, y) * trauma * trauma
		trauma -= delta
	else:
		if camera != null:
			camera = Vector2(0.0, 0.0)
