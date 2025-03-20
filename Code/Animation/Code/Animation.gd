extends Control

class_name Animate

func play():
	pass

func setText(newText: String):
	pass
	
func fadeIn():
	var fade = create_tween()
	fade.tween_property(self, "modulate:a", 1, 1)
	await fade.finished
	fade.kill()
	
func fadeOut():
	var fade = create_tween()
	fade.tween_property(self, "modulate:a", 0, 1)
	await fade.finished
	fade.kill()
