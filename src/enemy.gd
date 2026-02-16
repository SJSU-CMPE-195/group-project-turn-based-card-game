extends AnimatedSprite2D
class_name Enemy

func _ready():
	play()
	CombatManager.selected_enemy = self
