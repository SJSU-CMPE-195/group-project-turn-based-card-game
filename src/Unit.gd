@abstract
extends AnimatedSprite2D
class_name Unit

@onready var status_effects_component = $StatusEffectsComponent
@onready var health_component = $HealthComponent

# Signals
signal health_changed(current: int, max: int)
signal block_changed(current_block: int)
signal damage_taken(amount: int)
signal healed(amount: int)
signal died
signal turn_started
signal turn_ended

# Exported Stats
@export var max_health: int = 100

# Runtime State
var current_health: int
var block: int = 0
var is_dead: bool = false


func _ready():
	current_health = max_health
	connect_combat_manager()
	emit_signal("health_changed", current_health, max_health)


@abstract func connect_combat_manager()

func take_damage(amount: int) -> void:
	if is_dead:
		return
	
	var remaining_damage = amount
	
	# Block absorbs damage first
	if block > 0:
		var absorbed = min(block, remaining_damage)
		block -= absorbed
		remaining_damage -= absorbed
		emit_signal("block_changed", block)
	
	if remaining_damage > 0:
		current_health -= remaining_damage
		current_health = max(current_health, 0)
		emit_signal("damage_taken", remaining_damage)
		emit_signal("health_changed", current_health, max_health)
	
	if current_health <= 0:
		die()


func apply_status_effect(effect: StatusEffect):
	status_effects_component.add_status_effect(effect)

func heal(amount: int) -> void:
	if is_dead:
		return
	
	current_health += amount
	current_health = min(current_health, max_health)
	
	emit_signal("healed", amount)
	emit_signal("health_changed", current_health, max_health)


func add_block(amount: int) -> void:
	if is_dead:
		return
	
	block += amount
	emit_signal("block_changed", block)


func clear_block() -> void:
	block = 0
	emit_signal("block_changed", block)


func modify_max_health(amount: int) -> void:
	max_health += amount
	current_health = min(current_health, max_health)
	emit_signal("health_changed", current_health, max_health)


# ========================
# Turn Hooks
# ========================

func start_turn() -> void:
	if is_dead:
		return
	
	clear_block() # Slay the Spire style
	emit_signal("turn_started")


func end_turn() -> void:
	if is_dead:
		return
	
	emit_signal("turn_ended")


# ========================
# Death Handling
# ========================

func die() -> void:
	if is_dead:
		return
	
	is_dead = true
	died.emit()
	on_death()


func on_death() -> void:
	# Override in subclasses
	visible = false
