extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startShimmer()

var shimmer = true

func startShimmer():
	shimmer = true
	var energyTween
	while shimmer == true:
		energyTween = create_tween()
		energyTween.tween_property(self,"modulate:a",0.7,1)
		await energyTween.finished
		energyTween.stop()
		energyTween = create_tween()
		energyTween.tween_property(self,"modulate:a",0,2)
		await energyTween.finished
		energyTween.stop()
		
		
	
