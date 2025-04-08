extends CountdownEffect

class_name Effect_Burning

func _init(applicator: Card, target: Card, counter: int) -> void:
	texture = preload("res://assets/Icons/Burning Icon.png")
	super._init(applicator, target, counter)
	events = [Event_AllyTurn.new()]
	
func execute(event: Event):
	super.execute(event)
	gameState.damage(applicator,1,target)
	counter -= 1
	await gameState.executeEffects(Event_Generic.new("Burning"))
	if counter <= 0:
		remove()
