extends Room

func enter():
	$Fader.modulate = Color()
	await get_tree().create_timer(3.0).timeout
	var tween = create_tween()
	$Camera2D.zoom = Vector2.ONE * 0.95
	tween.tween_property($Fader, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.2)
	tween.tween_property($Camera2D, "zoom", Vector2.ONE * 1.0, 1.0).set_ease(tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	await tween.finished
	return

func on_entered():
	pass

func exit():
	var tween = create_tween()
	$Camera2D.zoom = Vector2.ONE * 1.0
	tween.tween_property($Camera2D, "zoom", Vector2.ONE * 0.97, 1.0).set_ease(tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property($Fader, "modulate", Color(0.0, 0.0, 0.0, 1.0), 0.2)
	await tween.finished
	SceneManager.exit_to_map()
