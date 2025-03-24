extends Control

@export var battleField: BattleManager

func _ready() -> void:
	$Battlefield.visible = true
