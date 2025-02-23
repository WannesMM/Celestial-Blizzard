extends Control

class_name LoadingScreen

var nextScene = "res://Scenes/Battle/battlefield.tscn"

var progressBar: LoadingBar

var progress = []
var progressTween: Tween
var value = 0

func _ready() -> void:
	modulate.v = 0
	generateTip()
	startLoad()
	$Control.resetProgress()
	
func _process(delta: float) -> void:
	ResourceLoader.load_threaded_get_status(nextScene,progress)
	
	if progress[0] == 1:
		GlobalSignals.loadingBlock.emit()
	
func startLoad():
	var fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 1, 1)
	await fadeTween.finished
	
	progressBar = $Control
	progressBar.resetProgress()
	ResourceLoader.load_threaded_request(nextScene)
	
	progressBar.tweenProgress(70)
	
	await GlobalSignals.loadingBlock
	
	progressBar.tweenProgress(90)
	
	var scene: PackedScene = ResourceLoader.load_threaded_get(nextScene)
	var battleField: BattleManager = scene.instantiate()
	
	print("Waiting for deck loading")
	battleField.initialiseDeck()
	
	progressBar.tweenProgress(100)
	
	await GlobalSignals.loadComplete
	
	print("Deck loading complete")
	
	var current_scene = get_tree().current_scene  # Get current scene
	
	AudioEngine.stopAllAudio()
	
	fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 0, 1)
	await fadeTween.finished
	
	# Add new scene to tree
	get_tree().root.add_child(battleField)
	get_tree().current_scene = battleField
	
	# Remove old scene
	current_scene.queue_free()

var tips = [
	"Did you know that Torinn Inn was the first card made for Celestial TCG, and Celestial Blizzard?",
	"Did you know that Celestial Sleeping was the most broken card ever made at it's release? It allowed the user to achieve infinite deck cycles.",
	"Did you know that there is an official wiki of Celestial TCG? Use it to uncover past changes and card specific attributes",
	"Did you know that Noma Greon is the most balanced character card ever, only receiving an HP nerf throughout it's lifetime",
	"Did you know that the area card Don Quixote's effect was changed numerous times, only to be reverted back to the original effect?",
	"Did you know that the ballista always gave you more gold than it required at launch?",
	"Did you know that there used to be a Demon of Nieuwtoren card that made one of your character cards a raid boss. It was removed due to being too unfun",
	"You can always rely on Greon's cooking pot.",
	"Did you know that the Generational Deception card was based on Victor Veratus' generational terror in the Towers Region?",
	"Bartholomew brings with him his NO1 supporter and an array of tennis cards, be careful because he will definitely get you (even off field).",
	"Did you know that the gallowing is the name of the first chapter in Celestial Spirit?",
	"Did you know that Red snow is the name of the second chapter in Celestial Spirit?",
	"Torrin's oil is useful",
	"Did you know that artificer armor used to be playable without Noma Greon in your deck?",
]

func generateTip():
	$Tip.text = tips[Random.generateRandom(1,0,tips.size() - 1)]
	
	
