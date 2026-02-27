extends Unit
class_name AllyUnit

func connect_combat_manager():
	play()
	CombatManager.selected_ally = self
