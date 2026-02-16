@tool
extends Node2D

@export_tool_button("Play")
var button = play
@export var target_position: Vector2 = Vector2(0.0, 0.0)
@export var target_height: float = 0.0

@export_category("Projectile Motion")
@export var max_height: float = 100.0
@export var flight_time: float = 1.0

@export_category("Visuals")
@export var show_landing_position: bool = true
@export var landing_radius: float = 50.0
@export var decal_duration: float = 5.0
@export var speed_stretch: float = 0.02

@onready var body = $Body
@onready var target = $Target

var progress: float = 0.0
var starting_pos: Vector2
var last_position: Vector2
var body_scale: float

signal target_reached

func play(scale_body: float = 1.0, scale_AOE: float = 1.0):
	set_circle(scale_AOE)
	body_scale = scale_body
	set_projectile_size(scale_body)
	var tween = create_tween()
	starting_pos = global_position
	last_position = starting_pos
	if target_position.y - global_position.y:
		$Body/ParticleTrail.draw_order = 1
		$Body/Body.show_behind_parent = false
	else:
		$Body/ParticleTrail.draw_order = 2
		$Body/Body.show_behind_parent = true
	tween.tween_method(update_position, 0.0, 1.0, flight_time)
	tween.tween_callback(impact)
	tween.tween_callback(reset).set_delay(decal_duration + 0.1)

func update_position(p: float):
	var pos: Vector2 = global_position + Vector2(0.0, body.position.y)
	var delta_position: Vector2 = pos - last_position
	var speed: float = delta_position.length()
	if speed > 0.001:  # avoid zero-length
		body.rotation = delta_position.angle()
		body.scale.x = body_scale + speed * speed_stretch
		
	global_position = lerp(starting_pos, target_position, p)
	body.position.y = target_height * p - 4.05 * max_height * p * (1 - p)
	last_position = pos
	
	if show_landing_position:
		target.global_position = target_position
		target.modulate = Color(1.0, 1.0, 1.0, pow(p, 3.0))

func reset():
	if !Engine.is_editor_hint():
		queue_free()
		return
	$Body/Body.visible = true
	global_position = Vector2(0.0, 0.0)
	progress = 0.0
	body.scale.x = 1.0
	body.rotation = 0.0
	target.modulate = Color(1.0, 1.0, 1.0, 0.0)
	$Decal.visible = false
	$Decal.modulate = Color(1.0, 1.0, 1.0, 1.0)
	$Target/LandingParticles.emitting = false
	$Body/ParticleTrail.emitting = true
	#$AreaOfEffect2D/MeshInstance2D.modulate = Color(1.0, 1.0, 1.0, 1.0)

func impact():
	target_reached.emit()
	if !Engine.is_editor_hint():
		VFX.start_shake(0.3)
	$Decal.visible = true
	var tween = create_tween()
	$Decal.modulate =  Color(1.4, 1.4, 1.4, 1.0)
	#tween.tween_property($AreaOfEffect2D/MeshInstance2D, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.2)
	tween.parallel().tween_property($Decal, "modulate", Color(1.0, 1.0, 1.0, 0.0), decal_duration).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_delay(0.5)
	$Body/Body.visible = false
	$Body/ParticleTrail.emitting = false
	$Target/LandingParticles.restart()
	$Target/LandingParticles.emitting = true

func set_circle(reticle_scale: float = 1.0):
	landing_radius *= reticle_scale
	#$AreaOfEffect2D/MeshInstance2D.mesh.size = Vector2(landing_radius, landing_radius) * 2.0
	$Target/LandingParticles.process_material.emission_ring_radius = landing_radius
	$Decal.mesh.size = Vector2(landing_radius, landing_radius) * 2.0

func set_projectile_size(body_scale: float = 1.0):
	body.scale = Vector2(body_scale, body_scale)


func set_target(target, randomness: float = 5.0):
	if target != null:
		if target is Vector2:
			target_position = target
		else:
			target_position = target.global_position
			#target_height = target.height
		
