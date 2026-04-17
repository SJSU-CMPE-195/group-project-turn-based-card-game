extends Node2D
class_name Map

@export var paths: int = 4
@export var path_length: int = 15
@export var splits: int = 3
@export var bridges: int = 4

@onready var node_scene = preload("res://MapNode.tscn")

@onready var camera: Camera2D = $Camera2D
@export var scroll_speed := 0.05

enum node_type { DEFAULT, SPLIT, BRIDGE, EMPTY }
enum room_type { COMBAT, SHOP, REWARD }

var path_arr: Array[Array] = []
var node_arr: Array[Array] = []


func _ready():
	randomize()
	generate()
	#randomize_rooms()
	add_bridges()
	trim_paths()
	assign_room_type()
	visualize()


func generate():

	path_arr.clear()

	for x in range(paths):

		var column: Array = []

		for y in range(path_length):

			column.append({
				"node": node_type.DEFAULT,
				"room": room_type.COMBAT,
				"bridges": []
			})

		path_arr.append(column)


# ------------------------------------------------------------
# ROOM RANDOMIZATION
# ------------------------------------------------------------

func randomize_rooms():

	for x in range(paths):
		for y in range(path_length):

			var r := randi() % 3

			match r:
				0: path_arr[x][y]["room"] = room_type.COMBAT
				1: path_arr[x][y]["room"] = room_type.SHOP
				2: path_arr[x][y]["room"] = room_type.REWARD


# ------------------------------------------------------------
# BRIDGE GENERATION (DIAGONAL FORWARD ONLY)
# ------------------------------------------------------------

func add_bridges():

	var placed := 0
	var attempts := 0

	while placed < bridges and attempts < 200:

		attempts += 1

		var x := randi() % paths
		var y := randi() % (path_length - 1)

		if path_arr[x][y]["node"] == node_type.BRIDGE:
			continue

		var dir := (randi() % 2) * 2 - 1
		var target_x := x + dir

		if target_x < 0 or target_x >= paths:
			continue

		path_arr[x][y]["node"] = node_type.BRIDGE
		path_arr[x][y]["bridges"].append(Vector2i(target_x, y + 1))

		placed += 1


# ------------------------------------------------------------
# LANE TRIMMING
# ------------------------------------------------------------

func trim_paths():
	pass
	#for x in range(paths):
		#for y in range(path_length):
#
			#var data = path_arr[x][y]
#
			#if data["node"] == node_type.BRIDGE:
				#if randf() < 0.1:
					#var step := 1
#
					#while y + step < path_length:
#
						#var next_node = path_arr[x][y + step]
#
						#if next_node["node"] != node_type.DEFAULT:
							#break
#
						#next_node["node"] = node_type.EMPTY
						#step += 1


# ------------------------------------------------------------
# VISUALIZATION
# ------------------------------------------------------------

func visualize():

	# clear old
	node_arr.clear()

	for c in get_children():
		if c is MapNode:
			c.queue_free()

	# spawn nodes (RECTANGULAR with null entries)

	for x in range(paths):

		var column: Array = []

		for y in range(path_length):

			var instance: MapNode = null

			if path_arr[x][y]["node"] != node_type.EMPTY:

				instance = node_scene.instantiate()
				add_child(instance)
				instance.set_room_type(path_arr[x][y]["room"])

				instance.position = Vector2(
					randf_range(-10.0, 10.0)
					+ (x * 50.0)
					- paths * 0.5 * 50.0,
					-y * 50.0
				)

			column.append(instance)

		node_arr.append(column)

	# connect nodes

	for x in range(paths):
		for y in range(path_length):

			var node: MapNode = node_arr[x][y]

			if node == null:
				continue

			# forward connection
			if y < path_length - 1:
				var forward = node_arr[x][y + 1]
				if forward != null:
					node.connect_to_node(forward)

			# bridges
			for bridge: Vector2i in path_arr[x][y]["bridges"]:
				var target = node_arr[bridge.x][bridge.y]
				if target != null:
					node.connect_to_node(target)

func assign_room_type():
	for x in range(paths):
		for y in range(path_length):

			var data = path_arr[x][y]

			if data["node"] == node_type.EMPTY:
				continue

			# force early game combat
			if y <= 1:
				data["room"] = room_type.COMBAT
				continue

			var roll := randf()

			if roll < 0.5:
				data["room"] = room_type.COMBAT
			elif roll < 0.75:
				data["room"] = room_type.REWARD
			else:
				data["room"] = room_type.SHOP



func _input(event):
	if event is InputEventPanGesture:
		var scroll : float = event.delta.y
		camera.position.y = clamp(camera.position.y + scroll * scroll_speed, -700.0, -100.0)
