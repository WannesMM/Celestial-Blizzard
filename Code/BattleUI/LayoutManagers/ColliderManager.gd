extends Control

class_name ColliderManager
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initializeLayouts()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initializeLayouts():
	$AllyCollider.initializeRespectiveCardLayout($AllyLayout)
	$EnemyCollider.initializeRespectiveCardLayout($EnemyLayout)
	
