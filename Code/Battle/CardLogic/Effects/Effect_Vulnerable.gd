extends CountdownEffect

class_name Effect_Vulnerable

func _init(applicator: Card, target: CharacterCard, counter: int) -> void:
	texture = preload("res://assets/Icons/Nerf Icon.png")
	info = "This card takes 1 additional damage"
	super._init(applicator,target,counter)
	events = [Event_EndOfRound.new()]
	target.damageReduction -= 1

func execute(event: Event):
	counter -= 1
	if counter < 1:
		target.damageReduction += 1
		remove()
