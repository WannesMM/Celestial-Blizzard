extends Message

func setTextInputMessage(message: String,pos: Vector2 = Vector2(0,0)):
	$Node2D/Label.text = message
	$Node2D.position = pos
	
func textSubmitted(new_text: String) -> void:
	GlobalSignals.textInputMessage.emit(new_text)
