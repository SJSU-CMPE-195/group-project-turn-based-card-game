extends Node2D

var slots: Array[Node2D] = []
var cards: Array[Card] = []

@export var left_bound: Node2D
@export var right_bound: Node2D
@export var max_cards: int = 9
@export var discard_pile: Node2D

func add_card(card_instance: Node):
	if cards.size() < max_cards:
		var slot_node = Node2D.new()
		slots.append(slot_node)
		cards.append(card_instance) # <-- needed
		card_instance.slot = slot_node
		add_child(slot_node)
		add_child(card_instance)

		reposition_slots()

func remove_card(card: Node):
	if not cards.has(card):
		return
	var slot = card.slot  # grab reference before erasing anything
	slots.erase(slot)
	cards.erase(card)
	reposition_slots()  # reposition remaining slots first
	slot.global_position = discard_pile.global_position  # then animate the removed slot
	card.visible = false
	await get_tree().create_timer(0.3).timeout
	slot.queue_free()

func reposition_slots():
	var n := slots.size()
	if n == 0:
		return

	var left_pos: Vector2 = left_bound.global_position
	var right_pos: Vector2 = right_bound.global_position

	var center: Vector2 = get_center()
	var width: float = left_pos.distance_to(right_pos)

	# tweak this for curvature feel
	var radius: float = width * 0.8

	# tweak this for how wide the fan is
	var start_angle: float = deg_to_rad(-30)
	var end_angle: float = deg_to_rad(30)

	for i in range(n):
		var slot: Node2D = slots[i]

		# center-expanding distribution
		var mid := (n - 1) / 2.0
		var offset := i - mid
		var t: float
		if mid == 0:
			t = 0.5
		else:
			t = (offset / mid) * 0.5 + 0.5

		# angle along arc
		var angle: float = lerp(start_angle, end_angle, t)

		# position along arc
		var pos := center + Vector2(sin(angle),-cos(angle)) * radius + Vector2(0.0, radius)

		# rotation across bounds
		var rot := lerp_angle(left_bound.global_rotation, right_bound.global_rotation, t)

		slot.global_position = pos
		slot.global_rotation = rot
	# Sort cards so leftmost is drawn last (on top)

func _process(delta):
	var sorted := cards.duplicate()

	sorted.sort_custom(func(a, b):
		return a.global_position.x > b.global_position.x
	)

	# Reorder in tree
	for card in sorted:
		move_child(card, get_child_count() - 1)

func get_center():
	var center: Vector2 = Vector2(0.5 * (right_bound.global_position.x + left_bound.global_position.x),0.5 * (right_bound.global_position.y + left_bound.global_position.y))
	return center

func get_card_rotation():
	var t: float = 0.5
	return lerp_angle(left_bound.rotation, right_bound.rotation, t)
