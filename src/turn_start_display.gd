extends Label

@onready var tween: Tween

func _ready():
	visible = false
	CombatManager.player_turn_ended.connect(_on_enemy_turn_start)
	CombatManager.enemy_turn_ended.connect(_on_player_turn_start)


func _on_enemy_turn_start():
	show_turn_text("Enemy Turn")


func _on_player_turn_start():
	show_turn_text("Player Turn")


func show_turn_text(t: String):
	text = t
	visible = true
	modulate.a = 0.0
	position.y -= 20   # start slightly above

	tween = create_tween()

	tween.tween_property(self, "modulate:a", 1.0, 0.25)
	tween.tween_property(self, "position:y", position.y + 20, 0.25)

	tween.tween_interval(0.6)

	tween.tween_property(self, "modulate:a", 0.0, 0.4)

	tween.finished.connect(func():
		visible = false
	)
