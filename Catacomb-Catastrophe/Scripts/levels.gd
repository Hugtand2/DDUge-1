extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called upon level startup
func setup() -> void:
	MusicPlayer.play_custom_track("res://Music/Ape Escape 2 ( Panic Pyramid ) Soundtrack  OST.mp3")
	pass


# Called upon user input
func reset_level() -> void:
	SceneManager.change_scene(get_tree().current_scene.scene_file_path)
	pass
