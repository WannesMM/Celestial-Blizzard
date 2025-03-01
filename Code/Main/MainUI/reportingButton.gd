extends Button

class_name ReportingButton
var number: int

func _pressed() -> void:
	GlobalSignals.choiceMessage.emit(number)
