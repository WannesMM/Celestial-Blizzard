extends Node

class_name GameState

var layoutManager: BattleManager = null

var allyState: PlayerState
var enemyState: PlayerState

var roundCounter: int = 0
var turnCounter: int = 0

var winner: PlayerState = null

func _init(allyDeck: Deck, allyInput: InputHandler, allyCharacterLayout: CardLayout, allyHandLayout: CardLayout, allyAreaSupport: AreaSupportLayout, allyEntity: EntityLayout,
enemyDeck: Deck, enemyInput: InputHandler, enemyCharacterLayout: CardLayout, enemyHandLayout: CardLayout, enemyAreaSupport: AreaSupportLayout, enemyEntity: EntityLayout, battleResources: BattleRightPanel,
layout: LayoutManager) -> void:
	setLayoutManager(layout)
	
	allyState = PlayerState.new(allyDeck, allyInput, allyCharacterLayout, allyHandLayout, allyAreaSupport, allyEntity, battleResources.allyResources, self)
	enemyState = PlayerState.new(enemyDeck, enemyInput, enemyCharacterLayout, enemyHandLayout, enemyAreaSupport, enemyEntity, battleResources.enemyResources, self)
	allyState.allied = true
	allyState.opponent = enemyState
	enemyState.allied = false
	enemyState.opponent = allyState
	startGame()
	
# GameLogic ----------------------------------------------------------------------------------------

var activePlayer: PlayerState: set = setActivePlayer

func startGame():
	
	print("Game start")
	
	allyState.getDeck().assignOwner(allyState)
	enemyState.getDeck().assignOwner(enemyState)
	allyState.shuffleDeck()
	enemyState.shuffleDeck()
	
	allyState.gainGold(8)
	enemyState.gainGold(8)
	
	var allyCards =  await allyState.getInputhandler().selectCards(allyState.getDeck().stackGetCharacters(), 1, "Select ally character")
	var allyCard: Card = allyCards[0]
	allyState.getDeck().stackRemoveCard(allyCard.getCardLogic())
	
	var enemyCards = await enemyState.getInputhandler().selectCards(enemyState.getDeck().getCharacterCards(), 1, "Select enemy character")
	var enemyCard = enemyCards[0]
	enemyState.getDeck().stackRemoveCard(enemyCard.getCardLogic())
	
	assert(allyCard == allyCard.cardLogic.card)
	
	allyState.playCard(allyCard)
	enemyState.playCard(enemyCard)
	allyState.setActiveCharacter(allyCard)
	enemyState.setActiveCharacter(enemyCard)
	
	allyState.drawCards(3)
	enemyState.drawCards(3)
	
	AudioEngine.playBattleMusic(1,1)
	executeRounds()
	
func executeRounds():
	while winner == null:
		
		#Initialise Round
		roundCounter += 1
		turnCounter = 0
		layoutManager.message("Round " + str(roundCounter))
		allyState.roundEnded = false
		allyState.drawCards(2)
		enemyState.roundEnded = false
		enemyState.drawCards(2)
		if roundCounter != 1:
			allyState.setGold(rollGold())
			enemyState.setGold(rollGold())
		else:
			var number = generateRandom(1,1,2)
			if number == 1:
				activePlayer = allyState
			elif number == 2:
				activePlayer = enemyState
			else:
				push_error("Random genereert een onmogelijk getal")
		
		await layoutManager.wait(2)
		
		#Turnloop
		while (allyState.roundEnded == false) or (enemyState.roundEnded == false):
			await executeTurn()
			nextActivePlayer()
		
func executeTurn():
	turnCounter += 1
	layoutManager.message("Turn " + str(turnCounter))
	
	await layoutManager.wait(2)
	
	if activePlayer.allied:
		layoutManager.message("Your turn")
	else:
		layoutManager.message("Enemy turn")
	
	while getActivePlayer().turnEnded == false:
		await getActivePlayer().chooseAction()
	activePlayer.turnEnded = false
	
func playCard(cardLogic: CardLogic, layout = null):
	getActivePlayer().playCard(cardLogic.getCard(), layout)
	
func getActivePlayer():
	return activePlayer
	
func rollGold():
	return generateRandom(2, 1, 8, "Advantage")
	
func generateRandom(x: int, min_value: int, max_value: int, mode: String = "Normal") -> int:
	if x <= 0:
		push_error("x must be greater than 0")
		return -1  # Error case
	var rolls = []  # Store all generated numbers
	for i in range(x):
		rolls.append(randi_range(min_value, max_value))  # Generate numbers
	match mode:
		"Normal":
			return rolls[randi() % rolls.size()]  # Return a random one
		"Advantage":
			return rolls.max()  # Return the highest roll
		"Disadvantage":
			return rolls.min()  # Return the lowest roll
	return rolls[0]  # Default case (shouldn't happen)
	
func nextActivePlayer():
	if !activePlayer.opponent.roundEnded:
		activePlayer = activePlayer.opponent	
	
func damage(attacker: CardLogic, dmg: int, defender: Card):
	defender.cardLogic.receiveDamage(dmg)
	
# Getter and Setters -------------------------------------------------------------------------------

func getLayoutManager():
	return layoutManager
	
func setLayoutManager(layout: LayoutManager):
	layoutManager = layout
	
func getAllyState():
	return allyState
	
func setAllyState(state: PlayerState):
	allyState = state
	
func getEnemyState():
	return enemyState
	
func setEnemyState(state: PlayerState):
	enemyState = state

func setActivePlayer(newPlayer: PlayerState):
	activePlayer = newPlayer
	if(activePlayer.allied):
		await AudioEngine.fadeVolume(0,2,1)
		AudioEngine.fadeVolume(-80,1,1)
	else:
		await AudioEngine.fadeVolume(0,1,1)
		AudioEngine.fadeVolume(-80,2,1)
