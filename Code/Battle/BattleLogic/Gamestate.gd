extends Node

class_name GameState

var layoutManager: BattleManager = null

var allyState: PlayerState
var enemyState: PlayerState

var roundCounter: int = 0
var turnCounter: int = 0

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
var lastTurnEnder: PlayerState
var playerWin: PlayerState = null

func startGame():
	
	print("Game start")
	AudioEngine.playAmbience("Wind",3,2)
	
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
	
	await allyState.playCard(allyCard)
	await enemyState.playCard(enemyCard)
	allyState.setActiveCharacter(allyCard)
	enemyState.setActiveCharacter(enemyCard)
	
	allyState.drawCards(3)
	enemyState.drawCards(3)
	
	increaseGamePhase()
	executeRounds()
	
func executeRounds():
	while playerWin == null:
		
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
			activePlayer = lastTurnEnder.opponent
		else:
			var number = Random.generateRandom(1,1,2)
			if number == 1:
				activePlayer = allyState
			elif number == 2:
				activePlayer = enemyState
			else:
				push_error("Random genereert een onmogelijk getal")
		
		await layoutManager.wait(2)
		
		#Turnloop
		while ((allyState.roundEnded == false) or (enemyState.roundEnded == false)) and playerWin == null:
			await executeTurn()
			nextActivePlayer()
		
	endGame(playerWin)
		
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
	return Random.generateRandom(2, 1, 8, "Advantage")
	
func nextActivePlayer():
	if !activePlayer.opponent.roundEnded:
		activePlayer = activePlayer.opponent	
	
func damage(attacker: CardLogic, dmg: int, defender: Card):
	await defender.cardLogic.receiveDamage(dmg)
	
func characterDefeated(card: CharacterCardLogic, player: PlayerState):
	checkGameWin(player)
	if playerWin == null:
		var switch = await player.input.chooseActiveCharacter()
		player.setActiveCharacter(switch[1])
		increaseGamePhase()
	
func checkGameWin(player: PlayerState):
	var allDefeated = true
	for card: Card in player.characterCards.addedCards:
		allDefeated = allDefeated and card.cardLogic.defeated
	if(allDefeated):
		playerWin = player.opponent
	
func endGame(winner: PlayerState):
	if(winner.allied):
		layoutManager.message("You Win")
	else:
		layoutManager.message("You Lost")
	await Random.wait(2)
	Random.callLoadingScreen("Title")
	
var gamePhase: int = 0

func increaseGamePhase():
	gamePhase = gamePhase + 1
	if gamePhase > 3:
		gamePhase = 3
	AudioEngine.playBattleMusic(1, floor(gamePhase / 2) + 1)
	
var scheduledEffects: Array[Effect] = []
	
func scheduleEffect(effect: Effect):
	scheduledEffects.append(effect)
	
	
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
