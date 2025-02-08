extends Node2D

class_name LayoutCollision

var validPlacement: bool = false
@export var cardLayout: CardLayout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/NinePatchRect.modulate.a = 0
	if cardLayout:
		cardLayout.collision = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	validPlacement = true

func _on_area_2d_mouse_exited() -> void:
	validPlacement = false

func getValidPlacement():
	return validPlacement

func getRespectiveCardLayout():
	return cardLayout

var opacityTween: Tween = null

func highlightRect():
	killOpacityTween()
	opacityTween = get_tree().create_tween()
	opacityTween.tween_property($Area2D/NinePatchRect, "modulate:a", 1.0, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
func undoHighlightRect():
	killOpacityTween()
	opacityTween = get_tree().create_tween()
	opacityTween.tween_property($Area2D/NinePatchRect, "modulate:a", 0, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
func killOpacityTween():
	if opacityTween and opacityTween.is_running():
		opacityTween.kill()
