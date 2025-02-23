extends Node
	
var music1: AudioStreamPlayer
var music2: AudioStreamPlayer
var ambience1: AudioStreamPlayer
var ambience2: AudioStreamPlayer
var sfx1: AudioStreamPlayer
var sfx2: AudioStreamPlayer
	
func _init() -> void:
	music1 = AudioStreamPlayer.new()
	music2 = AudioStreamPlayer.new()
	ambience1 = AudioStreamPlayer.new()
	ambience2 = AudioStreamPlayer.new()
	sfx1 = AudioStreamPlayer.new()
	sfx2 = AudioStreamPlayer.new()
	
	add_child(music1)
	add_child(music2)
	add_child(ambience1)
	add_child(ambience2)
	add_child(sfx1)
	add_child(sfx1)
	
func getChannel(channel: int):
	match channel:
		1:
			return music1
		2:
			return music2
		3:
			return ambience1
		4: 
			return ambience2
		5:
			return sfx1
		6:
			return sfx2

func playAudio(track: String, channel: int):
	var channelInstance = getChannel(channel)
	await fadeVolume(-80,channel,0.5)
	channelInstance.stream = load(track)
	channelInstance.volume_db = 0
	channelInstance.play()

func fadeVolume(volume: float, channel: int, duration: float = 1.0):
	var volumeTween: Tween = create_tween()
	volumeTween.tween_property(getChannel(channel),"volume_db",volume, duration).set_ease(Tween.EASE_IN_OUT)
	await volumeTween.finished
	volumeTween.kill()

func playBattleMusic(setNumber: int, fase: int):
	playAudio(loadMusicPath(setNumber, ((fase - 1) *2) + 1), 1)
	playAudio(loadMusicPath(setNumber, ((fase - 1) *2) + 2), 2)
	
func loadMusicPath(setNumber: int, trackNumber: int):
	return "res://assets/Audio/Music/Battle/Set" + str(setNumber) + "/" + str(trackNumber) + ".mp3"
