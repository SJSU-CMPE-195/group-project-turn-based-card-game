extends Node

var current_scene: Room
var combat_scenes: Array = ["res://CombatScene.tscn"]


func exit_to_map():
	await current_scene.exit()
	current_scene.queue_free()
	pass

func enter_combat_scene():
	var instance = load(combat_scenes[randi_range(0, combat_scenes.size() - 1)]).instantiate()
	get_tree().root.add_child(instance)
