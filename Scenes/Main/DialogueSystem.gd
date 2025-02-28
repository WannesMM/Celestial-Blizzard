extends Control

#var hover = false
#
#func startPortraitHover():
	#hover = true
	#var energyTween
	#while shimmer == true:
		#energyTween = create_tween()
		#energyTween.tween_property(self,"energy",9,1)
		#await energyTween.finished
		#energyTween.stop()
		#energyTween = create_tween()
		#energyTween.tween_property(self,"energy",5,2)
		#await energyTween.finished
		#energyTween.stop()
		#


func proceed() -> void:
	$TextContainer/TextBox.setText("How does this look, hopefully great? It needs to be mysterious and may never break immersion. It must convey the emotion that the game is good.")
