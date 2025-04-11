extends RichTextLabel

@export var fontPath = "res://assets/Font/zh-cn.ttf"

var displayText: String = "HIHIHIHIHAIHAIHAIAHIAHHISDHHDFISHDFJDSADFASDFLKJSLDKJFLKSJDLSKJLKSJDFLSKJLSKDJfHSIH": set = setDisplayText

var fade: int = 100: set = setFade
func fadeIn():
	fade = -100
	create_tween().tween_property(self,"fade",100,2.5)
	
func setFade(newFade: int):
	fade = newFade
	displayText = "[fade start=" + str(fade) + " length=11]" + displayText + "[/fade]"

func setDisplayText(displayText: String):
	text = "[font=" + fontPath + "]" + displayText + "[/font]"

func _ready() -> void:
	await Random.wait(1)
	displayText = "TEsttesttesttesttesttestest"
	fadeIn()
