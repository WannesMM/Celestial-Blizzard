extends Label

class_name LoadingBar

var progress: int = 0: set = setProgress
	
func setProgress(value: int):
	progress = value
	text = str(value) + "%"
	
func resetProgress():
	progress = 0
	
var progressTween: Tween
	
func tweenProgress(amt: int):
	if progressTween:
		progressTween.kill()
	progressTween = create_tween()
	progressTween.tween_property(self,"progress",amt,2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
