extends Control
@export var Combat_Scene: PackedScene
@export var Map_Generator: PackedScene
@export var Card_Shop: PackedScene
@export var Upgrade_Shop: PackedScene

func _on_combat_play_button_pressed() -> void:
	var combat
	combat = Combat_Scene.instantiate()
	var root = get_tree().root
	root.add_child(combat)
	self.hide()


func _on_map_button_pressed() -> void:
	var generator
	generator = Map_Generator.instantiate()
	var root = get_tree().root
	root.add_child(generator)
	self.hide()

func _on_card_button_pressed() -> void:
	var card
	card = Card_Shop.instantiate()
	var root = get_tree().root
	root.add_child(card)
	self.hide()

func _on_upgrade_button_pressed() -> void:
	var upgrade
	upgrade = Upgrade_Shop.instantiate()
	var root = get_tree().root
	root.add_child(upgrade)
	self.hide()
