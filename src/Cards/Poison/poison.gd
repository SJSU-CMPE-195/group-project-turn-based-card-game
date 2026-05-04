@tool
extends Card

func select_card():
	if CombatManager.player_energy >= cost:
		CombatManager.spend_energy(cost)
		await CombatManager.select_enemy()
		activate()
		CombatManager.deck_manager.remove_card(self)

func activate():
	var poison = preload("res://Status Effects/Poison.tres").duplicate()
	CombatManager.selected_enemy.apply_status_effect(poison)
	queue_free()

func _input(event):
	if event.is_action_pressed("select"):
		if z_index == 1:
			select_card()
