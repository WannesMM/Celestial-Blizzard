extends Control

class_name LoadingScreen

var nextScene = ""

var progressBar: LoadingBar

var progress = []
var progressTween: Tween
var value = 0

@export var battleFieldScene: String
@export var deckBuilderScene: String
@export var shopScene: String
@export var TitleScene: String
@export var storyScene: String

func _ready() -> void:
	modulate.v = 0
	generateTip()
	$Control.resetProgress()
	
func _process(delta: float) -> void:
	if nextScene != "":
		ResourceLoader.load_threaded_get_status(nextScene,progress)
		if progress[0] == 1:
			GlobalSignals.loadingBlock.emit()
	
func getScenePath(newScene: String):
	match newScene:
		"BattleField":
			return battleFieldScene
		"DeckBuilder":
			return deckBuilderScene
		"Title":
			return TitleScene
		"Shop":
			return shopScene
		"StartUp":
			return TitleScene
		"Story":
			return storyScene

func specificLoad(newScene, instance):
	match newScene:
		"BattleField":
			return battleSpecificLoad(instance)
		"DeckBuilder":
			return await deckBuilderSpecificLoad(instance)
		"Title":
			return titleSpecificLoad(instance)
		"Shop":
			return await shopSpecificLoad(instance)
		"StartUp":
			return await startUpSpecificLoad(instance)
		"Story":
			return storySpecificLoad(instance)

func battleSpecificLoad(battle):
	var battleField = battle.battleField
	var allyInput = PlayerInput.new(battleField)
	var enemyInput = PlayerInput.new(battleField)
	var test = BattleTest.new()
	
	var deck1: Deck = Deck.new(UserInfo.to_string_array(UserInfo.getAllCards()))
	var deck2 = test.burningDeck1
	
	
	battleField.initialiseGame(deck1,allyInput,deck2,enemyInput)
	return false
	
func deckBuilderSpecificLoad(deckBuilderInstance):
	return false
	
func shopSpecificLoad(shopInstance):
	await Random.message("Add ShopSpecificLoad in LoadingScreen",4)
	stopLoading()
	return true
	
func titleSpecificLoad(mainInstance):
	return false
	
func startUpSpecificLoad(instance):
	UserInfo.loadStory()
	if await checkConnection():
		var load = titleSpecificLoad(instance)
		return load
	return true

func storySpecificLoad(instance):
	return false

func checkConnection():
	if Server.requireConnection:
		var status = await Server.connectToServer()
		if status == 1 or status == 0 or await Server.getServerVersion() != Server.gameVersion:
			reloadConnection()
			return false
	return true
	
func startLoad(newScene: String = "BattleField", mode: String = "Normal"):
	nextScene = getScenePath(newScene)
	
	if mode == "Silent":
		$Control.visible = false
		$Tip.visible = false
	
	progressBar = $Control
	progressBar.resetProgress()
	
	var fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 1, 1)
	await fadeTween.finished
	
	progressBar.tweenProgress(25)
	
	ResourceLoader.load_threaded_request(nextScene)
	
	await GlobalSignals.loadingBlock
	
	progressBar.tweenProgress(50)
	
	var scene: PackedScene = ResourceLoader.load_threaded_get(nextScene)
	var instance = scene.instantiate()
	
	print("Scene specific load")
	progressBar.tweenProgress(100)
	if await specificLoad(newScene, instance):
		await GlobalSignals.loadComplete
	print("Loading complete")
	
	var loadingScene: LoadingScreen = get_tree().current_scene  # Get current scene
	
	AudioEngine.stopAudio(1)
	AudioEngine.stopAudio(2)
	
	fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 0, 1)
	await fadeTween.finished
	
	# Add new scene to tree
	get_tree().root.add_child(instance)
	get_tree().current_scene = instance
	
	# Remove old scene
	get_tree().root.remove_child(loadingScene)
	loadingScene.queue_free()
	
	pass

func stopLoading():
	var fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 0, 1)
	await fadeTween.finished
	
	Random.callLoadingScreen("Title")

func reloadConnection():
	var fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 0, 1)
	await fadeTween.finished
	
	Random.callLoadingScreen("StartUp")

var tips = [
	"Torinn Inn was the first card made for Celestial TCG, and Celestial Blizzard",
	"Celestial Sleeping was the most broken card ever made at it's release. It allowed the user to achieve infinite deck cycles.",
	"There exists an official wiki of Celestial TCG? Use it to uncover past changes and card specific attributes",
	"Noma Greon is the most balanced character card ever, only receiving an HP nerf throughout it's lifetime",
	"The area card Don Quixote's effect was changed numerous times, only to be reverted back to the original effect",
	"The ballista always gave you more gold than it required at launch",
	"There used to be a Demon of Nieuwtoren card that made one of your character cards a raid boss. It was removed due to being too unfun",
	"You can always rely on Greon's cooking pot.",
	"The Generational Deception card was based on Victor Veratus' generational terror in the Towers Region",
	"Bartholomew brings with him his NO1 supporter and an array of tennis cards, be careful because he will definitely get you (even off field).",
	"The gallowing is the name of the first chapter in Celestial Spirit",
	"Red snow is the name of the second chapter in Celestial Spirit",
	"Torrin's oil is useful",
	"Artificer armor used to be playable without Noma Greon in your deck",
	"Torinn Inn was the first character to ever win a battle in Celestial Blizzard.",
	"Celestial Blizzard was created in order to not have to deal with printers",
	"Not every opponent plays fair. Watch for signs of trickery during combat",
	"Justicia's hammer carries a burden heavier than it's weight.",
	"Never trust a cheap drink in Balder.",
	"Cultists love fire, or are they it's victim?",
	"Kin always offers a way out, but at what cost",
	"The Festival of the Towers celebrates an escape from the Black Forest. However, the past is never truly left behind.",
	"Ashrakt doesn’t just hunt. It chooses.",
	"The Wolf's mask hides more than just a face.",
	"Balder is like a phoenix, rising from the ashes.",
	"Not all debts are paid in gold, Patrin.",
	"The gods contradict themselves.",
	"Senna Nesleichim and distrust come as one",
	"Greon's homonculus did not last very long",
	]

func generateTip():
	$Tip.setDisplayText("[center][font_size=17]" + tips[Random.generateRandom(1,0,tips.size() - 1)] + "[/font_size][/center]")
	$Tip.fadeIn()
	
	
