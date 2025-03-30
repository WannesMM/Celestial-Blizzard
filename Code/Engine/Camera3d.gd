extends Camera3D

class_name Camera3d

func animateRotation(rotation: Vector3, duration: float):
	var rot = create_tween().tween_property(self, "rotation", rotation, duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	await rot.finished
	
var shimmerRot = false
	
func shimmerRotate():
	shimmerRot = !shimmerRot
	while shimmerRot:
		await animateRotation(Vector3(-10,0,0), 10)
		await animateRotation(Vector3(0,0,0), 10)

var shakeStrength := 0.0

func _process(delta: float) -> void:
	if shakeStrength > 0:
		shakeStrength = lerpf(shakeStrength,0,3 * delta)
		h_offset = randomOffset()

func shake(intensity: float = 0.1):
	shakeStrength = intensity
	
func randomOffset():
	return randf_range(-shakeStrength,shakeStrength)
