extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func displayCardInformation(card):
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
