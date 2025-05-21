extends Control

func _ready() -> void:
	await Random.wait(1)
	play()
	
func play():
	$BottomLeft/ColorRect/RichTextLabel.setDisplayText("Currently Playing")
	$BottomLeft/ColorRect/RichTextLabel.fadeIn(4)
	$BottomLeft/ColorRect/RichTextLabel2.setDisplayText("Spirit - Serenity")
	$BottomLeft/ColorRect/RichTextLabel2.fadeIn(4)
	
	
