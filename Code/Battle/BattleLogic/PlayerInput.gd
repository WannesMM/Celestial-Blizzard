extends InputHandler

class_name PlayerInput

var selectedCards
signal cardsSelected

var selectedAction
signal actionSelected


#Prompts the game UI to select cards out of an array of cards and then returns the selected cards.
func selectCards(cards, amount, message = "Select card(s)"):
	selectedCards = []
	while selectedCards == []:
		layoutManager.selectCardsMessage(self, cards, amount, message)
		await cardsSelected
	layoutManager.removeCurrentMessage()
	return selectedCards
	
#Allows the player to choose one of the following actions: Play card, Use move, End round, Discard card. This will return the result in the form of an array
func chooseAction():
	selectedAction = []
	layoutManager.allowAction = [1,2,3,4]
	layoutManager.currentInput = self
	while selectedAction == []:
		await actionSelected
	assert(selectedAction.size() != 0)
	layoutManager.allowAction = []
	layoutManager.currentInput = null
	return selectedAction

func chooseActiveCharacter():
	selectedAction = []
	layoutManager.allowAction = [4]
	layoutManager.currentInput = self
	while selectedAction == []:
		await actionSelected
	assert(selectedAction.size() != 0)
	layoutManager.allowAction = []
	layoutManager.currentInput = null
	return selectedAction
	
func setSelectedCards():
	selectedCards = layoutManager.getSelected().duplicate(false)
	cardsSelected.emit()

func setSelectedAction(action):
	selectedAction = action
	actionSelected.emit()
