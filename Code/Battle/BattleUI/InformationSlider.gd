extends Control

var layoutManager: LayoutManager = null
var currentCard: Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func displayCardInformation(card):
	currentCard = card
	var logic = card.getCardLogic()
	visible = true
	
	if(logic.getCardType() == "CharacterCard"):
		$PanelContainer/MarginContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value1.text = str(logic.getHP()) + " HP"
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getEnergy()) + " E"
		$PanelContainer/MarginContainer/VBoxContainer/NAname.text = logic.getNAName() + " - " + str(logic.getNAcost()) + "g"
		$PanelContainer/MarginContainer/VBoxContainer/NAdescription.text = logic.getNADescription()
		$PanelContainer/MarginContainer/VBoxContainer/SAname.text = logic.getSAName() + " - " + str(logic.getSAcost()) + "g"
		$PanelContainer/MarginContainer/VBoxContainer/SAdescription.text = logic.getSADescription()
		$PanelContainer/MarginContainer/VBoxContainer/CAname.text = logic.getCAName() + " - " + str(logic.getCAcost()) + "g " + str(logic.getCAenergyCost()) + "E"
		$PanelContainer/MarginContainer/VBoxContainer/CAdescription.text = logic.getCADescription()
		$PanelContainer/MarginContainer/VBoxContainer/AbilityName.text = logic.getAbilityName()
		$PanelContainer/MarginContainer/VBoxContainer/AbilityDescription.text = logic.getAbilityDescription()
	elif(logic.getCardType() == "AreaCard"):
		$PanelContainer/MarginContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/MarginContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/MarginContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/MarginContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityDescription.text = ""
	elif(logic.getCardType() == "SupporterCard"):
		$PanelContainer/MarginContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/MarginContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/MarginContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/MarginContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityDescription.text = ""
	elif(logic.getCardType() == "EventCard"):
		$PanelContainer/MarginContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/MarginContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/MarginContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/MarginContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityDescription.text = ""
	elif(logic.getCardType() == "EquipmentCard"):
		$PanelContainer/MarginContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/MarginContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/MarginContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/MarginContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityDescription.text = ""
	elif(logic.getCardType() == "EntityCard"):
		$PanelContainer/MarginContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/MarginContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/MarginContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/MarginContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/MarginContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/MarginContainer/VBoxContainer/AbilityDescription.text = ""

func closeCardInformation():
	visible = false

func NAbuttonPressed() -> void:
	layoutManager.characterCardMove("NA", currentCard)

func SAbuttonPressed() -> void:
	layoutManager.characterCardMove("SA", currentCard)

func CAbuttonPressed() -> void:
	layoutManager.characterCardMove("CA", currentCard)
