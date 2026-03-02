extends TextureRect

var effect: StatusEffect

func set_status_effect(status: StatusEffect):
	effect = status
	effect.removed.connect(remove)
	effect.updated.connect(refresh_status)
	refresh_status()

func refresh_status():
	texture = effect.icon
	if effect.duration != -1:
		$Label.text = str(effect.duration)
	else:
		$Label.visible = false

func remove(s):
	queue_free()
