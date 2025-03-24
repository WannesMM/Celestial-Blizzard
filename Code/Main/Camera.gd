extends Control

func zoomPosition(pos,zoom):
	pass
	
var shimmer = true

func startShimmer():
	shimmer = true
	var energyTween
	while shimmer == true:
		energyTween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		energyTween.tween_property($Camera2D,"zoom",Vector2(1.005,1.005),5)
		await energyTween.finished
		energyTween.stop()
		energyTween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		energyTween.tween_property($Camera2D,"zoom",Vector2(1,1),5)
		await energyTween.finished
		energyTween.stop()
		
func stopShimmer():
	shimmer = false

#Zoom --------------------------------------------------------------------------

func zoom(targetPosition: Vector2 = Vector2(0,0), zoomLevel: float = 1, duration: float = 4):
	var posTween = create_tween()
	var zoomTween = create_tween()
	
	posTween.tween_property($Camera2D, "position", targetPosition, duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	zoomTween.tween_property($Camera2D, "zoom", Vector2(zoomLevel,zoomLevel), duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	
	await posTween.finished
	await zoomTween.finished
	posTween.kill()
	zoomTween.kill

func zoomGlobal(targetPosition: Vector2 = Vector2(0,0), zoomLevel: float = 1, duration: float = 4):
	var posTween = create_tween()
	var zoomTween = create_tween()
	
	posTween.tween_property($Camera2D, "global_position", targetPosition, duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	zoomTween.tween_property($Camera2D, "zoom", Vector2(zoomLevel,zoomLevel), duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	
	await posTween.finished
	await zoomTween.finished
	posTween.kill()
	zoomTween.kill
