extends DirectionalLight3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moveIdle()

@export var idle: bool = false;

func moveIdle():
	while idle:
		var baseRotation = rotation
		var mov = create_tween().tween_property(self,"rotation",baseRotation + Vector3(0,0.02,0.01),10).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
		await mov.finished
		var mov2 = create_tween().tween_property(self,"rotation",baseRotation,11).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
		await mov2.finished
		
		
