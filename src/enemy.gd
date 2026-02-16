extends Sprite2D
class_name Enemy

func _ready():
	CombatManager.selected_enemy = self
