extends Unit
class_name AllyUnit

func connect_combat_manager():
	play()
	CombatManager.player_turn_start.connect(start_turn)
	CombatManager.player_turn_ended.connect(end_turn)
	CombatManager.selected_ally = self
	CombatManager.register_ally(self)
