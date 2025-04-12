extends StoryMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioEngine.playAmbience("Wind")
	AudioEngine.playStory("Story2")
	$DialogueSystem.startDialogue("1-1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
