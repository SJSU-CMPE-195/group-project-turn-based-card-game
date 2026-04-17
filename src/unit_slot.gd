extends Area2D
class_name UnitSlot

@export var unit: Node
var selected: bool = false
var hovered: bool = false

func _ready():
	area_entered.connect(hover)
	area_exited.connect(end_hover)

func hover(node):
	if not selected:
		hovered = true
		$SelectReticle.visible = true
		$SelectReticle.modulate = Color(1.0, 0.0, 0.0, 0.392)

func end_hover(node):
	if not selected:
		hovered = false
		$SelectReticle.visible = false

func select():
#
	#$SelectReticle.visible = true
	#$SelectReticle.modulate = Color(0.0, 1.0, 0.0, 0.392)
	CombatManager.select_unit(unit)

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if hovered:
			select()
