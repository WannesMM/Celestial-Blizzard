extends InputHandler

class_name PlayerInput

var selectedCards
signal cardsSelected

#Prompts the game UI to select cards out of an array of cards and then returns the selected cards.
func selectCards(cards, amount):
	selectedCards = []
	while selectedCards == []:
		layoutManager.selectCardsMessage(self, cards, amount, "Choose your starting Character")
		await cardsSelected
	layoutManager.removeCurrentMessage()
	return convertToCardLogic(selectedCards)
	
func setSelectedCards():
	selectedCards = layoutManager.getSelected().duplicate(false)
	cardsSelected.emit()
