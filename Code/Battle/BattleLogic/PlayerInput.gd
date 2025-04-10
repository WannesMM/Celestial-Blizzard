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
	
func chooseTarget(cards: Array[Card], amount, message = "Choose your Target"):
	selectedCards = []
	layoutManager.multiselect = amount
	layoutManager.newInput(self,[5])
	layoutManager.viableTargets = cards
	for card in cards:
		card.highlightOuterGlow()
	Random.message(message)
	while selectedCards == []:
		layoutManager.selectTarget()
		await cardsSelected
	layoutManager.multiselect = 1
	layoutManager.restoreInputSettings()
	layoutManager.viableTargets = []
	for card in cards:
		card.undoHighlightOuterGlow()
	return selectedCards
	
#Allows the player to choose one of the following actions: Play card, Use move, End round, Discard card. This will return the result in the form of an array
func chooseAction():
	selectedAction = []
	layoutManager.newInput(self,[1,2,3,4])
	while selectedAction == []:
		await actionSelected
	assert(selectedAction.size() != 0)
	layoutManager.restoreInputSettings()
	return selectedAction

func chooseActiveCharacter():
	layoutManager.newInput(self,[4])
	for card: CharacterCard in playerState.characterCards.addedCards:
		if card.defeated == false:
			card.highlightOuterGlow()
	
	if playerState.characterCards.addedCards.size() != 1:
		var guard: bool = false
		while guard == false:
			selectedAction = []
			Random.message("Choose a new active Character")
			guard = true
			while selectedAction == []:
				await actionSelected
				if selectedAction != []:
					if selectedAction[1].active:
						guard = false
		assert(selectedAction.size() != 0)
		assert(selectedAction[1].active == false)
	else:
		selectedAction = ["Switch",playerState.characterCards.addedCards[0]]
		
	for card: CharacterCard in playerState.characterCards.addedCards:
		if card.defeated == false:
			card.undoHighlightOuterGlow()
	layoutManager.restoreInputSettings()
	return selectedAction
	
func setSelectedCards():
	selectedCards = layoutManager.getSelected().duplicate(false)
	cardsSelected.emit()

func setSelectedAction(action):
	selectedAction = action
	actionSelected.emit()
