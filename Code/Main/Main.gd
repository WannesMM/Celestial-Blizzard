extends Control

var battleFieldPath: String = "res://Scenes/battlefield.tscn"
@export var loadingScene: String

func _ready() -> void:
	initializeUser()
	loadEnvironment(preload("res://Scenes/Environments/Forest.tscn"))

	modulate.v = 0
	#await doTitleAnimation()
	$Control/TitleLight.energy = 0
	$Account/SnowCrystal.modulate.a = 0
	audio()
	Random.wait(1)
	var fadeTween = create_tween()
	$Node3D/Camera3D.animateRotation(Vector3(0,0,0),4)
	$ColorRect.animateScale(Vector2(1,1))
	$ColorRect2.animateScale(Vector2(1,1))
	
	fadeTween.tween_property(self, "modulate:v", 1, 1)
	await fadeTween.finished
	$Control/TitleLight.energy = 0
	
func audio():
	$AudioStreamPlayer.stream = load("res://assets/Audio/Music/TitleScreen/Mainscreen" + str(Random.generateRandom(1,1,4)) + ".wav")
	$AudioStreamPlayer.play()
	AudioEngine.playAmbience("Wind",3,4)

func loadEnvironment(environment: PackedScene):
	var env: Env = environment.instantiate()
	$Node3D.add_child(env)
	$Node3D/Camera3D.position = env.baseCameraPosition
	$Node3D/Sprite3D.position.y = env.baseCameraPosition.y
	
func fadeScreen():
	var fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 0, 1)
	await fadeTween.finished
	
func loadBattlefield() -> void:
	await fadeScreen()
	Random.callLoadingScreen("BattleField")

var battleScaleTween: Tween

func BattleMouseEntered() -> void:
	battleScaleTween = create_tween()
	battleScaleTween.tween_property($Control/TitleLight,"energy",10,1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)

func BattleMouseExited() -> void:
	battleScaleTween = create_tween()
	battleScaleTween.tween_property($Control/TitleLight,"energy",0,1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)

func loadDuringLoadingScreen():
	Random.wait(1)
	GlobalSignals.loadComplete.emit()

func loadDeckbuilder() -> void:
	await fadeScreen()
	Random.callLoadingScreen("DeckBuilder")

func loadShop() -> void:
	await fadeScreen()
	Random.callLoadingScreen("Shop")

func accountMouseEntered() -> void:
	var shadeTween = create_tween()
	var fadeTween = create_tween()
	shadeTween.tween_property($Account/AccountLight,"energy",7.5,1)
	fadeTween.tween_property($Account/SnowCrystal,"modulate:a",1,1)
	await shadeTween.finished
	shadeTween.kill()
	fadeTween.kill()

func accountMouseExited() -> void:
	var shadeTween = create_tween()
	var fadeTween = create_tween()
	shadeTween.tween_property($Account/AccountLight,"energy",0,1)
	fadeTween.tween_property($Account/SnowCrystal,"modulate:a",0,1)
	await shadeTween.finished
	shadeTween.kill()
	fadeTween.kill()

func accountButton() -> void:
	pass

var titleAnimation = false

func doTitleAnimation():
	if titleAnimation:
		AudioEngine.playSFX("Title")
		await Random.wait(7)

func infoButton() -> void:
	var pdf_path = "res://File/Version pre-alpha info.pdf"  # Your PDF inside the project folder
	var absolute_path = ProjectSettings.globalize_path(pdf_path)
	OS.shell_open(absolute_path)

func wikiButton() -> void:
	var website_url = "https://celestial-tcg.fandom.com/wiki/Celestial_TCG_Wiki"
	OS.shell_open(website_url)  


func initializeUser() -> void:
	# For now enable all cards. In future this should come from the server.
	UserInfo.loadUserData()
