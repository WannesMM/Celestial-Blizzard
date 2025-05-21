extends Node3D

class_name Env

@export var audioTracks: Array[AudioTrack]

func _ready() -> void:
	AudioEngine.playTracks(audioTracks)
