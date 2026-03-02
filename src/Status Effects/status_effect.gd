@abstract
extends Resource
class_name StatusEffect

@export var name: String = "Poison"
@export var icon: Texture2D
@export_enum("Stack", "Refresh Duration", "Add Duration", "No Effect") var stacking_behavior: String = "Refresh Duration"
## Leave as -1 for permanent duration
@export var duration: int = -1
var stacks: int = 1
var unit: Unit

signal updated
signal removed(effect)

func on_turn_start():
	pass

func on_turn_end():
	pass

func on_damage_taken(amount: int):
	pass

func on_heal(amount: int):
	pass

func on_damage_dealt(amount: int):
	pass

func remove():
	removed.emit(self)

func stack():
	stacks += 1
