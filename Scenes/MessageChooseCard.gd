extends Control

class_name MessageChooseCard

var input: PlayerInput

func setMessage(message):
	$Label.text = message
	
func setButtonText(text):
	$Button.text = text
	
func addCards(cards):
	$SelectLayout.addCards(cards)

func setAmountSelectable(amt):
	$SelectLayout.amountSelectable = amt

func getSelectedCards():
	return $SelectLayout.selectedCards

func setInput(x):
	input = x

func _on_button_pressed() -> void:
	input.setSelectedCards()
