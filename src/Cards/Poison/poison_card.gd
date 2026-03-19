@tool 
extends Card
func select_card():
	await CombatManager.select_enemy()
	activate()
	
func activate():
	var poison
