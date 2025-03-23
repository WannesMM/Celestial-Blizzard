extends Control

var layoutManager: LayoutManager = null
var currentCard: Card

func _ready() -> void:
	hideAll()
	visible = false

func hideAll():
	for child in $Border/Scroll/VBoxContainer.get_children():
		child.visible = false

func displayCardInformation(card: Card):
	currentCard = card
	var titleCounter := 1
	var paramCounter := 1
	var buttonCounter := 1
	var textCounter := 1
	
	hideAll()
	
	for element in card.getDisplayInfo():
		match element[0]:
			"Title":
				match titleCounter:
					1:
						$Border/Scroll/VBoxContainer/Title/TitleBorder/Title.text = element[1]
						$Border/Scroll/VBoxContainer/Title.visible = true
					2:
						$Border/Scroll/VBoxContainer/Title2/TitleBorder/Title.text = element[1]
						$Border/Scroll/VBoxContainer/Title2.visible = true
					3:
						$Border/Scroll/VBoxContainer/Title3/TitleBorder/Title.text = element[1]
						$Border/Scroll/VBoxContainer/Title3.visible = true
				titleCounter += 1
			"Parameter":
				match paramCounter:
					1:
						$Border/Scroll/VBoxContainer/Parameter1.visible = true
					2:
						$Border/Scroll/VBoxContainer/Parameter2.visible = true
					3:
						$Border/Scroll/VBoxContainer/Parameter3.visible = true
				paramCounter += 1
			"Button":
				match buttonCounter:
					1:
						$Border/Scroll/VBoxContainer/Button/TitleBorder/Title.text = element[1]
						$Border/Scroll/VBoxContainer/Button.visible = true
					2:
						$Border/Scroll/VBoxContainer/Button2/TitleBorder/Title.text = element[1]
						$Border/Scroll/VBoxContainer/Button2.visible = true
					3:
						$Border/Scroll/VBoxContainer/Button3/TitleBorder/Title.text = element[1]
						$Border/Scroll/VBoxContainer/Button3.visible = true
				buttonCounter += 1
			"Portrait":
				$Border/Scroll/VBoxContainer/Portrait/PortraitMask/PortraitImage.setImage(element[1],Vector2(100,100),Vector2(0.7,0.7))
				$Border/Scroll/VBoxContainer/Portrait/PortraitMask/PortraitImage.scale = Vector2(0.1,0.1)
				$Border/Scroll/VBoxContainer/Portrait.visible = true
			"Text":
				match textCounter:
					1:
						$Border/Scroll/VBoxContainer/Text.text = element[1]
						$Border/Scroll/VBoxContainer/Text.visible = true
					2:
						$Border/Scroll/VBoxContainer/Text2.text = element[1]
						$Border/Scroll/VBoxContainer/Text2.visible = true
					3:
						$Border/Scroll/VBoxContainer/Text3.text = element[1]
						$Border/Scroll/VBoxContainer/Text3.visible = true
					4:
						$Border/Scroll/VBoxContainer/Text4.text = element[1]
						$Border/Scroll/VBoxContainer/Text4.visible = true
				textCounter += 1
	$Background.modulate = card.sampleColor
	visible = true

func closeCardInformation():
	visible = false

func NAbuttonPressed() -> void:
	layoutManager.characterCardMove("NA", currentCard)

func SAbuttonPressed() -> void:
	layoutManager.characterCardMove("SA", currentCard)

func CAbuttonPressed() -> void:
	layoutManager.characterCardMove("CA", currentCard)
