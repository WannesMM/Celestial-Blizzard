extends MultiMeshInstance3D

func _ready():
	if multimesh == null:
		return
	
	for i in range(multimesh.instance_count):
		var transform = Transform3D.IDENTITY
		transform.origin = Vector3(randf() * 50.0, 0, randf() * 50.0)  # Random position
		multimesh.set_instance_transform(i, transform)
