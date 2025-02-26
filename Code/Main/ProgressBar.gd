extends Control

class_name LoadingBar

var progress: int = 0: set = setProgress
var maxScale: float = 0.57
var defaultScale: float = 0.06
	
func setProgress(value: int):
	progress = value
	$Control/ProgressBar.text = str(value) + "%"
	
func resetProgress():
	progress = 0
	$ColorRect2/Sprite2D.scale = Vector2(defaultScale,defaultScale)
	$ColorRect2/ColorRect.scale = beginScale
	
var progressTween: Tween
var sizeTween: Tween
var rectTween: Tween

var beginScale = Vector2(0,0)
	
func tweenProgress(amt: int):
	if progressTween:
		progressTween.kill()
	progressTween = create_tween()
	progressTween.tween_property(self,"progress",amt,2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	
	if sizeTween:
		sizeTween.kill()
	var calc = (amt/100) * maxScale
	sizeTween = create_tween()
	sizeTween.tween_property($ColorRect2/Sprite2D,"scale",Vector2(calc,calc),1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	
	if rectTween:
		rectTween.kill()
	calc = (amt/100)
	rectTween = create_tween()
	rectTween.tween_property($ColorRect2/ColorRect,"scale",Vector2(calc,calc),1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
