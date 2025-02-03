extends Control

class_name MessageChooseCard

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
