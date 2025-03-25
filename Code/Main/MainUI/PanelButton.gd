extends Button

var callbackFunction: Callable

func ButtonPress() -> void:
	callbackFunction.call()
