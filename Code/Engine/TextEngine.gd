extends RichTextLabel

@export var fontPath = "res://assets/Font/baskerville bold bt.ttf"

var displayText: String = "": set = setDisplayText

@export var pulse: bool = false
@export var center: bool = true
@export var fontSize: int = 24

var fade: int = 100: set = setFade
func fadeIn(duration: float = 3):
	fade = -100
	create_tween().tween_property(self,"fade",125,duration)
	
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
	
func modulateText(value: float, duration: float = 1):
	await create_tween().tween_property(self,"modulate:a",value,duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO).finished
