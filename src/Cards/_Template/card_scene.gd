extends Node2D
class_name Card

@onready var card_art: TextureRect = $PanelContainer/MarginContainer/VBoxContainer/Control/CardArt
@onready var name_label = $PanelContainer/MarginContainer/VBoxContainer/Name
@onready var card_description = $PanelContainer/MarginContainer/VBoxContainer/Description
@onready var type = $PanelContainer/MarginContainer/VBoxContainer/Control/Type

@export_enum("Spell", "Attack") var card_type = "Not Set":
	set(t):
		if Engine.is_editor_hint():
			card_type = t
			if type != null:
				type.text = str(card_type)

@export var card_name: String = "Name":
	set(t):
		if Engine.is_editor_hint():
			card_name = t
			if name_label != null:
				name_label.text = card_name

@export var art: Texture2D = load("res://icon.svg"):
	set(t):
		if Engine.is_editor_hint():
			art = t
			if card_art != null:
				card_art.texture = art

@export_multiline var description: String = "Description":
	set(t):
		if Engine.is_editor_hint():
			description = t
			if card_description != null:
				card_description.text = description

@export var vfx_scene: PackedScene

var tween: Tween

func activate():
	push_error("ACTIVATE NOT IMPLEMENTED: extend this script and implement activate()")

func _ready():
	type.text = str(card_type)
	name_label.text = card_name
	card_art.texture = art
	card_description.text = description
	$PanelContainer.mouse_entered.connect(hover)
	$PanelContainer.mouse_exited.connect(end_hover)

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
