extends Resource

class_name AudioTrack

enum AudioType {Music, SFX, Ambience}

@export var track: AudioStream
@export var trackName: String = resource_path.get_basename().get_file()
@export var audioType: AudioType
@export var volume: float = 0
