extends Event

class_name Event_CharacterUsesMove

var character: CharacterCard
var move: String

func _init(card: Card = null, move: String = "") -> void:
	character = card
	self.move = move
