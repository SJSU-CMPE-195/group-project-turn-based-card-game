extends Control
class_name Card

@export var card_type: String = "Not Set"

@export var card_name: String = "Name"

@export var art: Texture2D = load("res://icon.svg")

@export_multiline var description: String = "Description"
			
@export var cost: int = 2

@export var vfx_scene: PackedScene

@onready var card_art: TextureRect = $PanelContainer/MarginContainer/VBoxContainer/Control/CardArt
@onready var name_label = $PanelContainer/MarginContainer/VBoxContainer/Name
@onready var card_description = $PanelContainer/MarginContainer/VBoxContainer/Description
@onready var type = $PanelContainer/MarginContainer/VBoxContainer/Control/Type
@onready var energy_cost = $PanelContainer/EnergyCost

var slot: Node2D

var tween: Tween

func activate():
	push_error("ACTIVATE NOT IMPLEMENTED: extend this script and implement activate()")

func select_card():
	pass

func _ready():
	$PanelContainer.mouse_entered.connect(hover)
	$PanelContainer.mouse_exited.connect(end_hover)
	$PanelContainer/EnergyCost.text = str(cost)
	$PanelContainer/MarginContainer/VBoxContainer/Description.text = description
	#if card_art != null:
		#$PanelContainer/MarginContainer/VBoxContainer/Control/CardArt.texture = card_art

func hover():
	z_index = 1.0
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.parallel().tween_property(self, "scale", Vector2(1.1, 1.1), 0.05)
	tween.parallel().tween_property(get_child(0), "position:y", -200.0, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)

func end_hover():
	z_index = 0.0
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.parallel().tween_property(self, "scale", Vector2(1.0, 1.0), 0.05)
	tween.parallel().tween_property(get_child(0), "position:y", -150.0, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)

func _process(delta):
	if slot != null:
		global_position = global_position.move_toward(slot.global_position, delta * clamp((global_position.distance_to(slot.global_position) * 10.0), 50, 2000.0))
		rotation = move_toward(rotation,slot.rotation, delta)
