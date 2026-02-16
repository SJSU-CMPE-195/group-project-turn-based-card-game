@tool
extends Card

func activate():
	var instance = vfx_scene.instantiate()
	CombatManager.selected_ally.add_child(instance)
	instance.set_target(CombatManager.selected_enemy)
	instance.play()

func _input(event):
	if event.is_action_pressed("select"):
		activate()
