extends AnimatedSprite2D
class_name AllyUnit

func _ready():
	play()
	CombatManager.selected_ally = self
