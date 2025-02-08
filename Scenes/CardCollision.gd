extends LayoutCollision

class_name CardCollision

@export var cardScene: Card

func collisionConstructor():
	cardScene.collision = self
