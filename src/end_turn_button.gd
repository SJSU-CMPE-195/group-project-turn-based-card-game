extends Button

func _ready():
	pressed.connect(end_turn)

func end_turn():
	if CombatManager.player_turn:
		pass
	CombatManager.end_turn()
