extends Control

class_name LoadingBar

var progress: int = 0: set = setProgress
var maxScale: float = 0.57
var defaultScale: float = 0.06
	
func setProgress(value: int):
	progress = value
	$ProgressBar.text = str(value) + "%"
	
func resetProgress():
	progress = 0
	$ColorRect2/Sprite2D.scale = Vector2(defaultScale,defaultScale)
	
var progressTween: Tween
var sizeTween: Tween
	
func tweenProgress(amt: int):
	if progressTween:
		progressTween.kill()
	progressTween = create_tween()
	progressTween.tween_property(self,"progress",amt,2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	
	if sizeTween:
		sizeTween.kill()
	var calc = (amt/100) * maxScale
	sizeTween = create_tween()
	sizeTween.tween_property($ColorRect2/Sprite2D,"scale",Vector2(calc,calc),2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
