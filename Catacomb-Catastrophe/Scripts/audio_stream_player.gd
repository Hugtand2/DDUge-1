extends AudioStreamPlayer

@onready var music_player: AudioStreamPlayer = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_custom_track("res://Music/Ancient Egyptian Music  Osiris.mp3")

func stop_music() -> void:
	music_player.stop()

func play_custom_track(file_path: String) -> void:
	var stream = load(file_path)
	if stream:
		music_player.stream = stream
		music_player.play()
