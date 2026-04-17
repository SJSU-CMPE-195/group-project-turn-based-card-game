extends MeshInstance2D

func fade_in():
	modulate = Color()
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.2)
	await tween.finished
	return

func fade_out():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 1.0), 0.2)
	await tween.finished
	return
