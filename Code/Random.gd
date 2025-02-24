extends Node

func generateRandom(x: int, min_value: int, max_value: int, mode: String = "Normal") -> int:
	if x <= 0:
		push_error("x must be greater than 0")
		return -1  # Error case
	var rolls = []  # Store all generated numbers
	for i in range(x):
		rolls.append(randi_range(min_value, max_value))  # Generate numbers
	match mode:
		"Normal":
			return rolls[randi() % rolls.size()]  # Return a random one
		"Advantage":
			return rolls.max()  # Return the highest roll
		"Disadvantage":
			return rolls.min()  # Return the lowest roll
	return rolls[0]  # Default case (shouldn't happen)

func wait(time: float):
	await get_tree().create_timer(time).timeout

var loadingScene = "res://Scenes/Main/LoadingScreen.tscn"

func callLoadingScreen(toLoad: String):
	var scene: PackedScene = load(loadingScene)
	var instance = scene.instantiate()
	
	var current_scene = get_tree().current_scene  # Get current scene
	get_tree().root.add_child(instance)
	get_tree().current_scene = instance
	instance.startLoad(toLoad)
	# Remove old scene
	current_scene.queue_free()
