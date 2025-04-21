extends RichTextLabel

@export var fontPath = "res://assets/Font/zh-cn.ttf"

var displayText: String = "": set = setDisplayText

@export var pulse: bool = false
@export var center: bool = true
@export var fontSize: int = 24

var fade: int = 100: set = setFade
func fadeIn():
	fade = -100
	create_tween().tween_property(self,"fade",125,3)
	
func setFade(newFade: int):
	#AudioEngine.playSFXmp3("SFX_Text")
	fade = newFade
	generateText("[fade start=" + str(fade) + " length=21]" + displayText + "[/fade]")

func generateText(newDisplayText: String):
	var generated: String = "[font=" + fontPath + "][font_size=" + str(fontSize) + "]" + newDisplayText + "[/font_size][/font]"
	if center:
		generated = "[center]" + generated + "[/center]"
	if pulse:
		generated = "[pulse freq=1.0 color=#ffffff40 ease=-2.0]" + generated + "[/pulse]"
	text = generated

func setDisplayText(newText: String):
	displayText = newText
	generateText(displayText)
	
