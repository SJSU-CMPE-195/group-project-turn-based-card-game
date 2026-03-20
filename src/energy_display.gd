extends Label

func _ready():
	CombatManager.energy_spent.connect(update)
	update()


func update():
	print("energy: ", CombatManager.player_energy)
	text = str(CombatManager.player_energy)
