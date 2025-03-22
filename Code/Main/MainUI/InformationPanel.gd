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
	var titleCounter := 1
	var paramCounter := 1
	var buttonCounter := 1
	var textCounter := 1
	
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
	visible = true

func closeCardInformation():
	visible = false

func NAbuttonPressed() -> void:
	layoutManager.characterCardMove("NA", currentCard)

func SAbuttonPressed() -> void:
	layoutManager.characterCardMove("SA", currentCard)

func CAbuttonPressed() -> void:
	layoutManager.characterCardMove("CA", currentCard)
