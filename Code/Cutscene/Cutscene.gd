extends Node3D

class_name Cutscene

func play():
	pass

func nextScene():
	GlobalSignals.eventActionComplete.emit()
