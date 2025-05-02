extends MultiMeshInstance3D

@export var area_size: Vector3 = Vector3(50.0, 0.0, 50.0)

func _ready():
	if multimesh == null:
		return
	for i in range(multimesh.instance_count):
		var transform = Transform3D.IDENTITY
		transform.origin = Vector3(
			randf() * area_size.x - area_size.x / 2.0,
			0, # Assuming you want trees at Y=0
			randf() * area_size.z - area_size.z / 2.0
		)
		multimesh.set_instance_transform(i, transform)
