extends Message

@export var selectionY: float = 100

func setChoiceMessage(message: String, options ,pos: Vector2 = Vector2(0,0)):
	$Node2D/Label.text = message
	$Node2D.position = pos
	var i = 0
	for option in options:
		var optionLabel = ReportingButton.new()
		optionLabel.number = i
		optionLabel.text = option
		if options.size() == 1:
			optionLabel.position = Vector2(0,0)
		else:
			optionLabel.position = Vector2(0, i * (selectionY / (options.size() - 1)))
		$Node2D.add_child(optionLabel)
		i += 1
