extends AudioStreamPlayer
# Autoload

@onready var music_player: AudioStreamPlayer = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_custom_track("res://Music/Ancient Egyptian Music  Osiris.mp3")

var current_track = ""

func stop_music() -> void:
	current_track = ""
	stop()

func play_custom_track(file_path: String) -> void:
	# Checks if track is already playing
	if current_track == file_path and playing:
		return
	current_track = file_path
	
	# Changes track
	var stream = load(file_path)
	if stream:
		stream.loop = true
		self.stream = stream
		play()
