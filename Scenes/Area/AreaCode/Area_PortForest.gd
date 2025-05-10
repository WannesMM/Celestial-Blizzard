extends Area

func story():
	super.story()
	var cutscene = load("res://Scenes/Cutscenes/Waking Up.tscn")
	get_tree().change_scene_to_packed(cutscene)
