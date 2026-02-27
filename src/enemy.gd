extends Unit
class_name Enemy

func connect_combat_manager():
	play()
	CombatManager.selected_enemy = self
