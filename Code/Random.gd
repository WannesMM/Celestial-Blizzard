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

func callLoadingScreen(toLoad: String, mode: String = "Normal"):
	var scene: PackedScene = load(loadingScene)
	var instance = scene.instantiate()
	
	var current_scene = get_tree().current_scene  # Get current scene
	get_tree().root.add_child(instance)
	get_tree().current_scene = instance
	instance.startLoad(toLoad, mode)
	# Remove old scene
	current_scene.queue_free()

var messageScene: String = "res://Scenes/Main/Message.tscn" 

func message(text = "message", duration: float = 1, position: Vector2 = Vector2(0,0)):
	var currentMessage = load(messageScene)
	var message = currentMessage.instantiate()
	message.setMessage(text, position)
	
	get_tree().current_scene.add_child(message)
	
	await message.fadeInOut(duration)
	
	get_tree().current_scene.remove_child(message)

var choiceMessageScene: String = "res://Scenes/Main/ChoiceMessage.tscn"

func choiceMessage(text, options ,duration: float = 1, position: Vector2 = Vector2(0,0)):
	var currentMessage = load(choiceMessageScene)
	var message = currentMessage.instantiate()
	message.setChoiceMessage(text, options,position)
	
	get_tree().current_scene.add_child(message)
	message.modulate.a = 1
	
	var result = await GlobalSignals.choiceMessage
	
	get_tree().current_scene.remove_child(message)
	return result

var textInputMessageScene: String = "res://Scenes/Main/TextInputMessage.tscn"

func textInputMessage(text,duration: float = 1, position: Vector2 = Vector2(0,0)):
	var currentMessage = load(textInputMessageScene)
	var message = currentMessage.instantiate()
	message.setTextInputMessage(text,position)
	
	get_tree().current_scene.add_child(message)
	message.modulate.a = 1
	
	var result = await GlobalSignals.textInputMessage
	
	get_tree().current_scene.remove_child(message)
	return result
