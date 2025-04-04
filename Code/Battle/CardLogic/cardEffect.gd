extends Effect

class_name CardEffect

var target: Card
var icon: Icon

func _init(applicator: Card, target: Card) -> void:
	super._init(applicator)
	self.target = target
	icon = iconScene.instantiate()
	icon.initialise(texture)
	target.addEffect(self)

func remove():
	super.remove()
	target.removeEffect(self)
