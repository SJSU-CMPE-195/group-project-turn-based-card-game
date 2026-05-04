@tool
extends Card

func select_card():
	if CombatManager.player_energy >= cost:
		CombatManager.spend_energy(cost)
		activate()
		CombatManager.deck_manager.remove_card(self)

func activate():
	CombatManager.selected_ally.heal(20)
	queue_free()

func _input(event):
	if event.is_action_pressed("select"):
		if z_index == 1:
			select_card()
