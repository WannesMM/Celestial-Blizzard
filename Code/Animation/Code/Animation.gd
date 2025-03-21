extends Control

class_name Animate

func play():
	pass

func play2():
	pass

func exitAnimation():
	pass

func removeSelf():
	queue_free()

func setText(newText: String):
	pass
	
func setPosition(pos: Vector2):
	position = pos
	
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
