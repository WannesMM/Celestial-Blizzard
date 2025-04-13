extends Node

var deck = []
var characters = []
var enabledCards = []
var enabledCharacters = []


# Deck functions
func getDeck():
	return deck.duplicate()

func addCardsToDeck(cards):
	for card in cards:
		if len(deck) > 60:
			printerr("Exceeded maximum deck size")
			return ERR_PARAMETER_RANGE_ERROR
		if not isCardEnabled(card):
			printerr("Cannot add card to deck. Card is not enabled: " + card)
			return ERR_PARAMETER_RANGE_ERROR

		# TODO: Check if card is not a character card
		deck.append(card)

func removeCardsFromDeck(cards):
	for card in cards:
		var cardIndex = deck.find(card)
		if cardIndex == -1:
			printerr("Cannot remove card from deck. Card was not in deck: " + card)
			return ERR_DOES_NOT_EXIST
		deck.remove_at(cardIndex)


# Character functions
func getCharacters():
	return characters.duplicate()

func addActiveCharacters(cards):
	# TODO: Check if card is a character card
	for card in cards:
		if len(characters) > 3:
			printerr("Exceeded maximum character limit")
			return ERR_PARAMETER_RANGE_ERROR
		characters.append(card)

func removeActiveCharacters(cards):
	for card in cards:
		var cardIndex = characters.find(card)
		if cardIndex == -1:
			printerr("Cannot remove character from deck. Card was not in deck: " + card)
			return ERR_DOES_NOT_EXIST
		characters.remove_at(cardIndex)


# Card enabling functions
func getEnabledCards():
	return enabledCards.duplicate()

func enableCards(cards):
	# TODO: Check if card is not a character card

	for card in cards:
		if not enabledCards.has(card):
			enabledCards.append(card)

func disableCards(cards):
	for card in cards:
		var cardIndex = enabledCards.find(card)
		if cardIndex == -1:
			printerr("Cannot disable card from deck. Card was not enabled: " + card)
			return ERR_DOES_NOT_EXIST
		enabledCards.remove_at(cardIndex)

func isCardEnabled(card: String) -> bool:
	return enabledCards.has(card)


# Character enabling functions
func getEnabledCharacters():
	return enabledCharacters.duplicate()

func enableCharacters(cards):
	# TODO: Check if card is a character card
	for card in cards:
		if not enabledCharacters.has(card):
			enabledCharacters.append(card)

func disableCharacters(cards):
	for card in cards:
		var cardIndex = enabledCharacters.find(card)
		if cardIndex == -1:
			printerr("Cannot disable character from deck. Card was not enabled: " + card)
			return ERR_DOES_NOT_EXIST
		enabledCharacters.remove_at(cardIndex)


# Save/Load functions
func saveUserData() -> bool:
	var save_data = {
		"deck": deck,
		"characters": characters,
		"enabledCards": enabledCards,
		"enabledCharacters": enabledCharacters
	}
	
	print(save_data)

	var save_file = FileAccess.open("user://save_data.json", FileAccess.WRITE)
	if save_file:
		save_file.store_string(JSON.stringify(save_data, "  "))
		save_file.close()
		print("User data saved successfully")
		return true
	else:
		printerr("Failed to save user data")
		return false

func loadUserData() -> bool:
	var save_file = FileAccess.open("user://save_data.json", FileAccess.READ)
	if not save_file:
		printerr("No save data found")
		return false
		
	var json_text = save_file.get_as_text()
	save_file.close()

	var json = JSON.new()
	var error = json.parse(json_text)

	if error == OK:
		var data: Dictionary = json.get_data()  

		if data.has("deck"):
			deck = data.deck
		if data.has("characters"):
			characters = data.characters
		if data.has("enabledCards"):
			enabledCards = data.enabledCards
		if data.has("enabledCharacters"):
			enabledCharacters = data.enabledCharacters
			
		print("User data loaded successfully")
		return true
	else:
		printerr("JSON Parse Error: " + json.get_error_message() + " at line " + str(json.get_error_line()))
		return false
