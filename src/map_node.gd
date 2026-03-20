extends MeshInstance2D
class_name MapNode

var connected_nodes: Array = []
var room_type = 0



func connect_to_node(node: Node2D):
	connected_nodes.append(node)
	var line:= Line2D.new()
	line.z_index = -1
	add_child(line)
	line.width = 1.0
	line.add_point(Vector2(0.0, 0.0))
	line.add_point(node.global_position - global_position)

func set_room_type(type: Map.room_type):
	room_type = type
	match type:
		0:
			self_modulate = Color(1.0, 0.42, 0.42, 1.0)
		1:
			self_modulate = Color(0.787, 0.68, 1.0, 1.0)
		2:
			self_modulate = Color(1.0, 0.778, 0.42, 1.0)


func _on_button_pressed():
	match room_type:
		0:
			SceneManager.enter_combat_scene()
		1:
			self_modulate = Color(0.787, 0.68, 1.0, 1.0)
		2:
			self_modulate = Color(1.0, 0.778, 0.42, 1.0)
	pass # Replace with function body.
