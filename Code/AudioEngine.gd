extends Node

#Settings
var disableAudio: bool = false

class TrackPair:
	func _init(audioTrack: AudioTrack, player: AudioStreamPlayer) -> void:
		self.audioTrack = audioTrack
		self.player = player
	
	var audioTrack: AudioTrack
	var player: AudioStreamPlayer
	
	func play(remover: Callable):
		player.play()
		player.volume_db = audioTrack.volume
		await player.finished
		remover.call(self)

var tracks: Array[TrackPair]

func playTrack(track: AudioTrack):
	var trackPair: TrackPair = createTrackPair(track)
	tracks.append(trackPair)
	trackPair.play(removeTrackPair)
	
func removeTrack(track: AudioTrack):
	removeTrackPair(searchTrackPair(track))

func playTracks(tracks: Array[AudioTrack]):
	for track: AudioTrack in tracks:
		playTrack(track)

func removeAllTracks():
	for track: TrackPair in tracks:
		removeTrackPair(track)

func searchTrackPair(track: AudioTrack):
	for trackPair: TrackPair in tracks:
		if trackPair.audioTrack == track:
			return trackPair
	
func removeTrackPair(trackPair: TrackPair):
	await stopAudioTrack(trackPair)
	remove_child(trackPair.player)
	trackPair.player.queue_free()
	tracks.erase(trackPair)

func stopAudioTrack(trackPair: TrackPair):
	await create_tween().tween_property(trackPair.player,"volume_db",-80,4).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO).finished
	trackPair.player.stop()

func createTrackPair(track: AudioTrack) -> TrackPair:
	var audioPlayer: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(audioPlayer)
	audioPlayer.stream = track.track
	
	return TrackPair.new(track, audioPlayer)
