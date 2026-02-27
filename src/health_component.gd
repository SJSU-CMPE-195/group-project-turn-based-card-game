extends ProgressBar
class_name HealthComponent

var unit: Unit
var flash_tween: Tween

@onready var tween: Tween = create_tween()

func _ready():
	unit = get_parent()
	
	unit.damage_taken.connect(display_damage)
	unit.healed.connect(display_heal)
	unit.health_changed.connect(update_health)
	
	update_health(unit.current_health, unit.max_health)


# ========================
# Health Updating
# ========================

func update_health(current: int, max: int) -> void:
	max_value = max
	$ProgressBar.max_value = max
	value = current
	
	tween.kill()
	tween = create_tween()
	tween.tween_property($ProgressBar, "value", current, 0.6)
	# You can finish adding smoothing / delayed bar logic here


# ========================
# Flash Effects
# ========================

func display_damage(amount: int) -> void:
	flash(Color.RED)


func display_heal(amount: int) -> void:
	flash(Color.GREEN)


func flash(color: Color) -> void:
	# Stop previous tween if still running
	if flash_tween and flash_tween.is_running():
		flash_tween.kill()
	
	unit.modulate = color
	
	flash_tween = create_tween()
	flash_tween.tween_property(
		unit,
		"modulate",
		Color.WHITE,
		0.1
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
