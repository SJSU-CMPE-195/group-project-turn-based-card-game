extends Node

var selected_ally: AllyUnit
var selected_enemy: Enemy

var selecting: bool = false

var turn_count: int = 0
var player_turn: bool = true
var target_select_hint: Node

signal enemy_selected
signal unit_selected
signal turn_ended
signal enemy_turn_start
signal player_turn_start

func end_turn():
	turn_ended.emit()
	turn_count += 1
	player_turn = !player_turn

func begin_turn():
	if player_turn:
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
	unit_selected.emit()
