@tool
extends Card

func select_card():
	await CombatManager.select_enemy()
	activate()

func activate():
	var instance = vfx_scene.instantiate()
	CombatManager.selected_ally.add_child(instance) ## adds the vfx as a child of the ally unit
	instance.global_position -= Vector2(0.0, 50.0)
	instance.set_target(CombatManager.selected_enemy) ## set target of the attack, attack animates to target position
	instance.play() ## starts the vfx animation
	await instance.target_reached
	var burn = preload("res://Status Effects/Burn.tres").duplicate()
	CombatManager.selected_enemy.apply_status_effect(burn)
	CombatManager.selected_enemy.take_damage(20)
	CombatManager.end_turn()
	

func _input(event):
	if event.is_action_pressed("select"): ## Activates when input is "Selected"
		select_card()
