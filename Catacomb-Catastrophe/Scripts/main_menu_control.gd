extends Control

@onready var play_button: TextureButton = $MainMenuPlayButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func button_pressed() -> void:
	MusicPlayer.volume_db = -10
	SceneManager.change_scene("res://Cutscenes/Intro_cutscene/intro_cutscene.tscn")
