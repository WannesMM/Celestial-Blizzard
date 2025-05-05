extends Node

# Deck and Cards ---------------------------------------------------------------

var deck = []
var characters = []
var enabledCards = []
var enabledCharacters = []

func getAllCards():
	return deck.duplicate() + characters.duplicate()

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
		var allCards = FileAccess.open("res://File/Cards.json", FileAccess.READ)
		var json = JSON.new()
		json.parse(allCards.get_as_text())
		var data: Dictionary = json.get_data()
		
		var characters = []
		var cards = []
		for card in data.keys():
			if data[card]["Script"].contains("Character"):
				characters.append(card)
			else:
				cards.append(card)
		enableCards(cards)
		enableCharacters(characters)
		
		saveUserData()
		return false
		
	var json_text = save_file.get_as_text()
	save_file.close()

	var json = JSON.new()
	var error = json.parse(json_text)

	if error == OK:
		var data = json.get_data()  

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


func to_string_array(input: Array) -> Array[String]:
	var result: Array[String] = []
	for item in input:
		if typeof(item) == TYPE_STRING:
			result.append(item)
		else:
			result.append(str(item))  # or skip if strict
	return result

# Story and world -------------------------------------------------------------

const SavePath := "user://SaveData.cfg"
const GameStaticPath := "res://Code/Story/CelestialBlizzard.tres"

var game: Game = Game.new()

func loadStory():
	var gameStatic: GameStatic = load(GameStaticPath)

	game.staticGameData = gameStatic

	var config: ConfigFile = ConfigFile.new()
	var err = config.load(SavePath)
	
	for worldStatic: WorldStatic in gameStatic.worlds:
		var world: World = World.new()
		
		game.worlds.append(world)
		world.staticWorldData = worldStatic
		
		world.currentStoryAreaId = config.get_value("%s" % [worldStatic.id], "currentArea", "")
		world.currentChapter = config.get_value("%s" % [worldStatic.id], "currentChapter", "")

		for areaStatic: AreaStatic in worldStatic.areas:
			var area: StoryArea = StoryArea.new()
			
			world.areas.append(area)
			area.staticAreaData = areaStatic

			var section := "%s/%s" % [worldStatic.id, areaStatic.id]
			
			area.activeEvents = config.get_value(section, "ActiveEvents", [])
			
	if err != OK:
		print("No save file found. Starting new game.")
		game.worlds[0].currentChapter = "Intro"
		game.worlds[0].currentStoryAreaId = "Area_PortForest"

func saveStory() -> void:
	var config := ConfigFile.new()

	for world: World in game.worlds:
		var worldId: String = world.staticWorldData.id
		
		config.set_value("%s" % [worldId], "currentArea", world.currentStoryAreaId)
		config.set_value("%s" % [worldId], "currentChapter", world.currentChaper)

		for area in world.areas:
			var areaId: String = area.staticAreaData.id
			var section := "%s/%s" % [worldId, areaId]

			config.set_value(section, "ActiveEvents", area.ActiveEvents)

	var err = config.save(SavePath)
	if err != OK:
		print("Error saving game!")
	else:
		print("Game saved to %s" % SavePath)
