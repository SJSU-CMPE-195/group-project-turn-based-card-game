extends Node

var selected_ally: AllyUnit
var selected_enemy: Enemy

var enemies: Array
var allies: Array

var selecting: bool = false

var turn_count: int = 0
var player_turn: bool = true
var target_select_hint: Node

var max_player_energy: int = 5
var player_energy: int = 5

var deck_manager

signal enemy_selected
signal ally_selected
signal unit_selected
signal enemy_turn_ended
signal player_turn_ended
signal enemy_turn_start
signal player_turn_start
signal combat_started
signal energy_spent

func register_ally(unit: Unit):
	allies.append(unit)
	unit.died.connect(ally_died)

func register_enemy(unit: Unit):
	enemies.append(unit)
	unit.died.connect(enemy_died)

func end_turn():
	print("ENDING: ", player_turn)
	if player_turn:
		player_turn_ended.emit()
	else:
		enemy_turn_ended.emit()
	turn_count += 1
	player_turn = !player_turn
	begin_turn()

func begin_turn():
	if player_turn:
		create_energy(max_player_energy - player_energy)
		deck_manager.draw_card()
		player_turn_start.emit()
	else:
		enemy_turn_start.emit()

func select_enemy():
	target_select_hint.visible = true
	await enemy_selected
	target_select_hint.visible = false
	return

func select_unit(unit: Unit):
	if unit is Enemy:
		selected_enemy = unit
		enemy_selected.emit()
	else:
		selected_ally = unit
		ally_selected.emit()
	unit_selected.emit()

func begin_combat():
	begin_turn()
	for i in range(5):
		deck_manager.draw_card()
		await get_tree().create_timer(0.2).timeout
	combat_started.emit()

func create_energy(amount: int):
	player_energy += amount
	energy_spent.emit()

func spend_energy(amount: int):
	player_energy -= amount
	energy_spent.emit()

func enemy_died():
	for enemy: Node in enemies:
		if !enemy.is_dead:
			return
	win_combat()

func ally_died():
	for enemy in enemies:
		if !enemy.is_dead:
			return
	lose_combat()

func win_combat():
	SceneManager.exit_to_map()
	pass

func lose_combat():
	SceneManager.exit_to_map()
	pass
