extends Control

func zoomPosition(pos,zoom):
	pass
	
var shimmer = true

func startShimmer():
	shimmer = true
	var energyTween
	while shimmer == true:
		energyTween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		energyTween.tween_property($Camera2D,"zoom",Vector2(1.01,1.01),5)
		await energyTween.finished
		energyTween.stop()
		energyTween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		energyTween.tween_property($Camera2D,"zoom",Vector2(1,1),5)
		await energyTween.finished
		energyTween.stop()
		
func stopShimmer():
	shimmer = false
