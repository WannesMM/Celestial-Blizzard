extends Effect

class_name CardEffect

var target: Card
var icon: Icon
var info: String = "This is an effect"

func _init(applicator: Card, target: Card) -> void:
	super._init(applicator)
	self.target = target
	icon = iconScene.instantiate()
	icon.initialise(texture)
	icon.setInfo(info)
	target.addEffect(self)

func remove():
	super.remove()
	target.removeEffect(self)
