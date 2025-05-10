extends Control

class_name TitleScreen

func _ready() -> void:
	loadEnvironment(preload("res://Scenes/Environments/Fog.tscn"))
	audio()
	openCurrentScreen()
	$Node3D/Camera3D.shimmerIdle()
	
func loadEnvironment(environment: PackedScene):
	var env: Env = environment.instantiate()
	$Node3D.add_child(env)
	$Node3D/Camera3D.position = env.baseCameraPosition
	$Node3D/AnimatedLogo.position.y += env.baseCameraPosition.y
	$Node3D/AnimatedLogo/Label3D.position.y += env.baseCameraPosition.y

func audio():
	$AudioStreamPlayer5.play()
	await Random.wait(5)
	$AudioStreamPlayer.stream = load("res://assets/Audio/Music/TitleScreen/Mainscreen" + str(Random.generateRandom(1,1,4)) + ".wav")
	$AudioStreamPlayer.play()

func MiddleScreenLeftButtonPressed() -> void:
	previousScreen()
	
func MiddleScreenRightButtonPressed() -> void:
	nextScreen()

class Screen:
	var visual: TitleScreen
	func _init(titleScreen) -> void:
		visual = titleScreen
	
	func getRotation() -> Vector3:
		return Vector3(0,0,0)
		
	func open():
		pass
		
	func close():
		pass

class MainScreen extends Screen:
	func open():
		visual.openMainScreen()
		
	func close():
		visual.closeMainScreen()
	
class AccountScreen extends Screen:
	func getRotation():
		return Vector3(0,1.2,0)
		
	func open():
		visual.openAccountScreen()
		
	func close():
		visual.closeAccountScreen()

class InfoScreen extends Screen:
	func getRotation():
		return Vector3(0,-1.2,0)

var screens: Array[Screen] = [AccountScreen.new(self), MainScreen.new(self), InfoScreen.new(self)]
var currentScreen: int = 1

func nextScreen():
	if screens.size() -1 > currentScreen:
		closeCurrentScreen()
		currentScreen += 1;
		openCurrentScreen()
		$Left.visible = true
	if !(screens.size() -1 > currentScreen):
		$Right.visible = false
		
func previousScreen():
	if 0 < currentScreen:
		closeCurrentScreen()
		currentScreen -= 1;
		openCurrentScreen()
		$Right.visible = true
	if !(0 < currentScreen):
		$Left.visible = false

func openCurrentScreen():
	var screen = screens[currentScreen]
	$Node3D/Camera3D.animateRotation(screen.getRotation(),2)
	screen.open()

func closeCurrentScreen():
	var screen = screens[currentScreen]
	screen.close()
	
# Individual Screens -----------------------------------------------------------

func openMainScreen():
	$Middle.visible = true
	$Node3D/AnimatedLogo/GPUParticles3D2.emitting = true
	create_tween().tween_property($Node3D/AnimatedLogo,"modulate:a",1,1)

func closeMainScreen():
	$Middle.visible = false
	$Node3D/AnimatedLogo/GPUParticles3D2.emitting = false
	create_tween().tween_property($Node3D/AnimatedLogo,"modulate:a",0,0.25)

func openAccountScreen():
	$Acount.position.x = -100
	$Acount.modulate.a = 0
	$Acount.visible = true
	create_tween().tween_property($Acount,"position:x",0,1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	create_tween().tween_property($Acount,"modulate:a",1,1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	$Acount/RichTextLabel.setDisplayText("Account")
	$Acount/RichTextLabel.fadeIn()
	$Acount/TitleBorder2/RichTextLabel2.setDisplayText("Nessa of Loch")
	$Acount/TitleBorder2/RichTextLabel2.fadeIn()
	$Acount/TitleBorder2/RichTextLabel3.setDisplayText("Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here.Your account info here. Your account info here. Your account info here. Your account info here.")
	$Acount/TitleBorder2/RichTextLabel3.fadeIn()
	
func closeAccountScreen():
	var tween = create_tween().tween_property($Acount,"position:x",-100,1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property($Acount,"modulate:a",0,0.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	await tween.finished
	$Acount.visible = false
