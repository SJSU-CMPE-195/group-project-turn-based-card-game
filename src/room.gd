@abstract
extends Node
class_name Room

func _ready():
	SceneManager.current_scene = self
	await enter()
	on_entered()

@abstract func on_entered()

@abstract func enter()

@abstract func exit()
