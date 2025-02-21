extends Control

class_name MessageChooseCard

var input: PlayerInput

func setMessage(message):
	$Label.text = message
	
func setButtonText(text):
	$Button.text = text
	
func addCards(cards):
	$SelectLayout.addCards(cards)

func getAddedCards():
	return $SelectLayout.getAddedCards()

func removeAllCards():
	$SelectLayout.removeAllCards()

func setAmountSelectable(amt):
	$SelectLayout.amountSelectable = amt

func getSelectedCards():
	return $SelectLayout.selectedCards

func setInput(x):
	input = x

func _on_button_pressed() -> void:
	if input.layoutManager.selectedCards.size() != 0:
		input.setSelectedCards()
	else:
		if input.layoutManager.multiselect == 1:
			input.layoutManager.message("Choose " + str(input.layoutManager.multiselect) + " card")
		else:
			input.layoutManager.message("Choose " + str(input.layoutManager.multiselect) + " cards")
