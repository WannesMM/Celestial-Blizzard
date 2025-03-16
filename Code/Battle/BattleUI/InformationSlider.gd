extends Control

var layoutManager: LayoutManager = null
var currentCard: Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func displayCardInformation(card):
	currentCard = card
	var logic = card
	visible = true
	
	if(logic.getCardType() == "CharacterCard"):
		$PanelContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/VBoxContainer/KeyValues/Value1.text = str(logic.getHP()) + " HP"
		$PanelContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getEnergy()) + " E"
		$PanelContainer/VBoxContainer/NAname.text = logic.getNAName() + " - " + str(logic.getNAcost()) + "g"
		$PanelContainer/VBoxContainer/NAdescription.text = logic.getNADescription()
		$PanelContainer/VBoxContainer/SAname.text = logic.getSAName() + " - " + str(logic.getSAcost()) + "g"
		$PanelContainer/VBoxContainer/SAdescription.text = logic.getSADescription()
		$PanelContainer/VBoxContainer/CAname.text = logic.getCAName() + " - " + str(logic.getCAcost()) + "g " + str(logic.getCAenergyCost()) + "E"
		$PanelContainer/VBoxContainer/CAdescription.text = logic.getCADescription()
		$PanelContainer/VBoxContainer/AbilityName.text = logic.getAbilityName()
		$PanelContainer/VBoxContainer/AbilityDescription.text = logic.getAbilityDescription()
	elif(logic.getCardType() == "AreaCard"):
		$PanelContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/VBoxContainer/AbilityDescription.text = ""
	elif(logic.getCardType() == "SupporterCard"):
		$PanelContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/VBoxContainer/AbilityDescription.text = ""
	elif(logic.getCardType() == "EventCard"):
		$PanelContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/VBoxContainer/AbilityDescription.text = ""
	elif(logic.getCardType() == "EquipmentCard"):
		$PanelContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/VBoxContainer/AbilityDescription.text = ""
	elif(logic.getCardType() == "EntityCard"):
		$PanelContainer/VBoxContainer/CardName.text = logic.getCardName()
		$PanelContainer/VBoxContainer/KeyValues/Value1.text = "Cost:"
		$PanelContainer/VBoxContainer/KeyValues/Value2.text = str(logic.getCardCost()) + "g"
		$PanelContainer/VBoxContainer/NAname.text = logic.getEffectName()
		$PanelContainer/VBoxContainer/NAdescription.text = logic.getCardDescription()
		$PanelContainer/VBoxContainer/SAname.text = ""
		$PanelContainer/VBoxContainer/SAdescription.text = ""
		$PanelContainer/VBoxContainer/CAname.text = ""
		$PanelContainer/VBoxContainer/CAdescription.text = ""
		$PanelContainer/VBoxContainer/AbilityName.text = ""
		$PanelContainer/VBoxContainer/AbilityDescription.text = ""

func closeCardInformation():
	visible = false

func NAbuttonPressed() -> void:
	layoutManager.characterCardMove("NA", currentCard)

func SAbuttonPressed() -> void:
	layoutManager.characterCardMove("SA", currentCard)

func CAbuttonPressed() -> void:
	layoutManager.characterCardMove("CA", currentCard)
