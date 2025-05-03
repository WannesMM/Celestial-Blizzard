extends MultiMeshInstance3D
# Attach this to a node (or the scene root)
@export var tree_material: ShaderMaterial

func _process(delta):
	if tree_material:
		tree_material.set_shader_parameter("wind_phase", Time.get_ticks_msec() / 1000.0)
