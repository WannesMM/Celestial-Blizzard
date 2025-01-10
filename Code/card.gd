extends Node2D

var DEFAULTSCALE = null
const ANIMATIONSCALE = Vector2(1.19,1.19)
const ANIMATIONDURATION: float = 0.19

var scaleTween: Tween = null

func _ready() -> void:
	DEFAULTSCALE = self.scale

func assignDefaultScale(scaled: Vector2):
	DEFAULTSCALE = scaled
	self.scale = scaled
	
func _on_area_2d_mouse_entered() -> void:
	print("Entered cardcollision")
	$ColorRect.mouseEntered()
	scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
	
func _on_area_2d_mouse_exited() -> void:
	print("Exited cardcollision")
	$ColorRect.mouseExited()
	scaleRelative(Vector2(1,1), ANIMATIONDURATION)

func scaleRelative(target_ratio, duration):
	
	var scaler = DEFAULTSCALE.x * target_ratio.x
	scaleTo(Vector2(scaler, scaler), duration)

func scaleTo(target_scale: Vector2, duration: float):
	
	if scaleTween:
		scaleTween.kill
	
	scaleTween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	print(str(scaleTween))
	scaleTween.tween_property(self, "scale", target_scale, duration)
	
func _on_color_rect_mouse_entered() -> void:
	pass # Replace with function body.


func _on_color_rect_mouse_exited() -> void:
	pass # Replace with function body.
