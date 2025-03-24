extends Control

func _ready() -> void:
	modulate.a = 0

func displayCard(card: Card, duration: float = 1):
	$Layout.addCard(card)
	var fadeTween = create_tween()
	fadeTween.tween_property(self,"modulate:a",1, 0.5)
	await fadeTween.finished
	fadeTween.kill()
	
	await Random.wait(duration)
	
	fadeTween = create_tween()
	fadeTween.tween_property(self,"modulate:a",0, 0.5)
	await fadeTween.finished
	fadeTween.kill()
	$Layout.removeCard(card)
