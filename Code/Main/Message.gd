extends Control

class_name Message

func _ready() -> void:
	pass
	self.modulate.a = 0

func setMessage(message):
	$Node2D/Label.text = message

func fadeInOut(duration = 1):
	var tween = create_tween()
	var sizeTween = create_tween()
	sizeTween.tween_property($Node2D, "scale", Vector2(1.15,1.15), duration*2)
	tween.tween_property(self, "modulate:a", 1.0, duration)  # Fade to full opacity
	await tween.finished
	tween.kill
	
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, duration)
	await tween.finished
	sizeTween.kill
	tween.kill
	self.size = Vector2(1,1)
	return true
