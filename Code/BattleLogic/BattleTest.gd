extends Node

class_name BattleTest

var TorinnInn1: CharacterCardLogic = null
var TorinnInn2: CharacterCardLogic = null
var TorinnInn3: CharacterCardLogic = null

var NomaGreon1: CharacterCardLogic = null
var NomaGreon2: CharacterCardLogic = null
var NomaGreon3: CharacterCardLogic = null

var BartholomewBalderstone1: CharacterCardLogic = null
var BartholomewBalderstone2: CharacterCardLogic = null
var BartholomewBalderstone3: CharacterCardLogic = null

var HatsuneMiku1: CharacterCardLogic = null
var HatsuneMiku2: CharacterCardLogic = null
var HatsuneMiku3: CharacterCardLogic = null

var berlaar: AreaCardLogic = null
var dqMall: AreaCardLogic = null
var monsterMayhem: AreaCardLogic = null

var deck1: Deck = null
var deck2: Deck = Deck.new([HatsuneMiku.new()])
var deck3: Deck = null

var burningDeck: Deck = Deck.new([TorinnInn.new(), Kin.new(), FragmentumGeneral.new(), Berlaar.new(), Berlaar.new(), TowersRegion.new(), TowersRegion.new(),
	Homunculus.new(), Homunculus.new(), PseudoDragon.new(), PseudoDragon.new(), PseudoDragon.new(), MonsterMayhem.new(), MonsterMayhem.new(), Hermit.new(), Hermit.new(),
	DQMall.new(), DQMall.new(), NieuwToren.new(), Ballista.new(), Ballista.new(), GreonsCookingPot.new(), GreonsCookingPot.new(), GreonsCookingPot. new()
	])

var burningDeck2: Deck = Deck.new([TorinnInn.new(), Kin.new(), FragmentumGeneral.new(), Berlaar.new(), Berlaar.new(), TowersRegion.new(), TowersRegion.new(),
	Homunculus.new(), Homunculus.new(), PseudoDragon.new(), PseudoDragon.new(), PseudoDragon.new(), MonsterMayhem.new(), MonsterMayhem.new(), Hermit.new(), Hermit.new(),
	DQMall.new(), DQMall.new(), NieuwToren.new(), Ballista.new(), Ballista.new(), GreonsCookingPot.new(), GreonsCookingPot.new(), GreonsCookingPot. new()
	])

func _init() -> void:
	pass
	
	
	
	
