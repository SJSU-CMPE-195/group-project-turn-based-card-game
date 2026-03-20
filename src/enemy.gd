extends Unit
class_name Enemy

func connect_combat_manager():
	CombatManager.enemy_turn_start.connect(start_turn)
	CombatManager.enemy_turn_ended.connect(end_turn)
	CombatManager.register_enemy(self)
	play()
