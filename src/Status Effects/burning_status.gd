extends StatusEffect
class_name BurningStatus

@export var tick_damage: int = 1

func on_turn_start():
	unit.take_damage(tick_damage)
	duration -= 1
	updated.emit()
	pass

func on_turn_end():
	pass

func on_damage_taken(amount: int):
	pass

func on_heal(amount: int):
	pass

func on_damage_dealt(amount: int):
	pass
