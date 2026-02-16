@tool
extends Node2D
class_name Card

@export_enum("Spell", "Attack") var card_type = "Not Set":
	set(t):
		if Engine.is_editor_hint():
			card_type = t
			type.text = str(card_type)

@export var card_name: String = "Name":
	set(t):
		if Engine.is_editor_hint():
			card_name = t
			name_label.text = card_name

@export var art: Texture2D = load("res://icon.svg"):
	set(t):
		if Engine.is_editor_hint():
			art = t
			card_art.texture = art

@export_multiline var description: String = "Description":
	set(t):
		if Engine.is_editor_hint():
			description = t
			card_description.text = description

@export var vfx_scene: PackedScene

@onready var card_art: TextureRect = $PanelContainer/MarginContainer/VBoxContainer/CardArt
@onready var name_label = $PanelContainer/MarginContainer/VBoxContainer/Name
@onready var card_description = $PanelContainer/MarginContainer/VBoxContainer/Description
@onready var type = $PanelContainer/MarginContainer/VBoxContainer/Control/Type

func activate():
	push_error("ACTIVATE NOT IMPLEMENTED: extend this script and implement activate()")
