extends Control

class_name MainScreen

func _ready() -> void:
	loadEnvironment()
	openCurrentScreen()
	$MainUI/LaunchSFX.play()
	area.camera.shimmerIdle()
	
var area: Area
	
func loadEnvironment():
	var staticAreaData: AreaStatic = UserInfo.game.currentWorld.currentStoryArea.getStaticAreaData()
	var environment = load(staticAreaData.environment)
	area = environment.instantiate()
	
	area.areaId = staticAreaData.id
	area.worldId = UserInfo.game.currentWorld.getStaticWorldData().id
	area.storyArea = UserInfo.game.currentWorld.currentStoryArea
	
	$StoryUI/Area.add_child(area)

func MiddleScreenLeftButtonPressed() -> void:
	previousScreen()
	
func MiddleScreenRightButtonPressed() -> void:
	nextScreen()

class Screen:
	var visual: MainScreen
	func _init(titleScreen) -> void:
		visual = titleScreen
	
	func getRotation() -> Vector3:
		return Vector3(0,0,0)
		
	func open():
		pass
		
	func close():
		pass

class CenterScreen extends Screen:
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

var screens: Array[Screen] = [AccountScreen.new(self), CenterScreen.new(self), InfoScreen.new(self)]
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
	area.camera.animateRotation(screen.getRotation(),2)
	screen.open()

func closeCurrentScreen():
	var screen = screens[currentScreen]
	screen.close()
	
# Individual Screens -----------------------------------------------------------

func openMainScreen():
	$MainUI/TitleScreen.visible = true
	$MainUI/TitleScreen/Node3D/AnimatedLogo/GPUParticles3D2.emitting = true
	create_tween().tween_property($Node3D/AnimatedLogo,"modulate:a",1,1)

func closeMainScreen():
	$Middle.visible = false
	$MainUI/TitleScreen/Node3D/AnimatedLogo/GPUParticles3D2.emitting = false
	create_tween().tween_property($MainUI/TitleScreen/Node3D/AnimatedLogo,"modulate:a",0,0.25)

func openAccountScreen():
	$MainUI/AccountScreen.position.x = -100
	$MainUI/AccountScreen.modulate.a = 0
	$MainUI/AccountScreen.visible = true
	create_tween().tween_property($Acount,"position:x",0,1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	create_tween().tween_property($Acount,"modulate:a",1,1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	$MainUI/AccountScreen/RichTextLabel.setDisplayText("Account")
	$MainUI/AccountScreen/RichTextLabel.fadeIn()
	$MainUI/AccountScreen/TitleBorder2/RichTextLabel2.setDisplayText("Nessa of Loch")
	$MainUI/AccountScreen/TitleBorder2/RichTextLabel2.fadeIn()
	$MainUI/AccountScreen/TitleBorder2/RichTextLabel3.setDisplayText("Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here. Your account info here.Your account info here. Your account info here. Your account info here. Your account info here.")
	$MainUI/AccountScreen/TitleBorder2/RichTextLabel3.fadeIn()
	
func closeAccountScreen():
	var tween = create_tween().tween_property($MainUI/AccountScreen,"position:x",-100,1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property($MainUI/TitleScreen/Node3D/AnimatedLogo,"modulate:a",0,0.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	await tween.finished
	$MainUI/AccountScreen.visible = false

func TitleButtonPressed() -> void:
	$MainUI/Right.disabled = true
	$MainUI/Left.disabled = true
	var tween = create_tween().tween_property($MainUI, "modulate:a", 0, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	create_tween().tween_property($MainUI/TitleScreen/Node3D/AnimatedLogo, "modulate:a", 0, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	create_tween().tween_property($MainUI/TitleScreen/Node3D/AnimatedLogo/Label3D, "modulate:a", 0, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	$MainUI.visible = false
	area.triggerEvents()
	
