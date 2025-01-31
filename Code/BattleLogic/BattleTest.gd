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

var deck1: Deck = null
var deck2: Deck = null
var deck3: Deck = null

func _init() -> void:
	TorinnInn1 = TorinnInn.new()
	TorinnInn2 = TorinnInn.new()
	TorinnInn3 = TorinnInn.new()
	
	NomaGreon1 = NomaGreon.new()
	NomaGreon2 = NomaGreon.new()
	NomaGreon3 = NomaGreon.new()
	
	BartholomewBalderstone1 = BartholomewBalderstone.new()
	BartholomewBalderstone2 = BartholomewBalderstone.new()
	BartholomewBalderstone3 = BartholomewBalderstone.new()
	
	HatsuneMiku1 = HatsuneMiku.new()
	HatsuneMiku2 = HatsuneMiku.new()
	HatsuneMiku3 = HatsuneMiku.new()
	
	deck1 = Deck.new([TorinnInn1, NomaGreon1, BartholomewBalderstone1, HatsuneMiku1])
	deck2 = Deck.new([HatsuneMiku1, HatsuneMiku2, HatsuneMiku3])
	deck3 = Deck.new([TorinnInn1])
	
