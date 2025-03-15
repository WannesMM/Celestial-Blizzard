extends LayoutCollision

class_name CardCollision

@export var cardScene: Card

func collisionConstructor():
	visible = true
	cardScene.collision = self

func disableCollision():
	cardScene.collision1()
	
func enableCollision():
	cardScene.collision1and2()
