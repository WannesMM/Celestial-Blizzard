extends Control

var callBack: Callable

func setCallBack(callBack: Callable):
	self.callBack = callBack

func _ready() -> void:
	$RichTextLabel.modulateText(0,0)
	if not has_node("ClearTimer"):
		var timer = Timer.new()
		timer.name = "ClearTimer"
		timer.wait_time = 3.0  
		timer.one_shot = true
		timer.autostart = false
		add_child(timer)
		timer.timeout.connect(_on_clear_timer_timeout)

func ScreenInput() -> void:
	$RichTextLabel.setDisplayText("Skip")
	$RichTextLabel.modulateText(1,0.5)
	$Button2.visible = true

	var timer = $ClearTimer
	timer.stop()
	timer.start()

func _on_clear_timer_timeout() -> void:
	await $RichTextLabel.modulateText(0,1)
	$RichTextLabel.setDisplayText("")
	$Button2.visible = false
	
func SkipPressed() -> void:
	callBack.call()
