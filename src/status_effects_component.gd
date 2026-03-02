extends GridContainer
class_name StatusEffectsComponent

var active_effects: Array[StatusEffect] = []
@onready var tile = preload("res://StatusEffectTile.tscn")

func add_status_effect(new_effect: StatusEffect):
	for effect in active_effects:
		if effect.name == new_effect.name:
			match effect.stacking_behavior:
				"Stack":
					effect.stack()
				"Refresh Duration":
					effect.duration = new_effect.duration
				"Add Duration":
					effect.duration += new_effect.duration
				"No Effect":
					pass
			return
	var instance = tile.instantiate()
	instance.set_status_effect(new_effect)
	add_child(instance)
	active_effects.append(new_effect)
	new_effect.removed.connect(remove_status_effect)

func remove_status_effect(effect: StatusEffect):
	active_effects.erase(effect)
