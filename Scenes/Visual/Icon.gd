extends Node2D

class_name Icon

func initialise(texture: Texture) -> void:
	if texture:
		$Image.texture = texture
	
func setUses(uses: String = ""):
	$Label.visible = true
	if uses == "-1":
		$Label.text = ""
	else:
		$Label.text = uses

func showInfo() -> void:
	if $Label2.text != "":
		var tween = create_tween().tween_property($Label2,"modulate:a",1,0.5)

func hideInfo() -> void:
	var tween = create_tween().tween_property($Label2,"modulate:a",0,0.5)

func setInfo(text: String):
	$Label2.text = text
