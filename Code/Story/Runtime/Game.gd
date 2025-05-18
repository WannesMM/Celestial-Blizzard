extends Node

class_name Game

var worlds: Array[World] = []
var currentWorld: World
var activeWorlds: Array[World] = []

func getStaticGameData() -> GameStatic:
	return load("res://Code/Story/CelestialBlizzard.tres")
