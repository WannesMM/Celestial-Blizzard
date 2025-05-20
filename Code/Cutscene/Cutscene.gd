extends Node3D

class_name Cutscene

func _ready() -> void:
	var skip = preload("res://Scenes/Cutscenes/CutsceneSkipButton.tscn").instantiate()
	skip.setCallBack(nextScene)
	add_child(skip)
	play()

func play():
	pass

func skip():
	pass

func nextScene():
	GlobalSignals.eventActionComplete.emit()
