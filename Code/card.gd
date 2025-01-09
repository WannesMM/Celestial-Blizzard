extends Node2D

const DEFAULTSCALE = Vector2(1,1)
const ANIMATIONSCALE = Vector2(1,1)
const ANIMATIONDURATION: float = 0.7

#var scaleTween: Tween = null

func _ready() -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	print("Entered cardcollision")
	$ColorRect.mouseEntered()
	scaleTo(ANIMATIONSCALE,ANIMATIONDURATION)
	
func _on_area_2d_mouse_exited() -> void:
	print("Exited cardcollision")
	$ColorRect.mouseExited()
	scaleTo(DEFAULTSCALE,ANIMATIONDURATION)

func scaleTo(target_scale: Vector2, duration: float):
	#if scaleTween:
		#scaleTween.kill()
	
	var scaleTween = get_tree().create_tween()
	print(str(scaleTween))
	scaleTween.tween_property(self, "scale", target_scale, duration)
	
func _on_color_rect_mouse_entered() -> void:
	pass # Replace with function body.


func _on_color_rect_mouse_exited() -> void:
	pass # Replace with function body.
