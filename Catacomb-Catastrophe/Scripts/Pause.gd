class_name PauseMenu extends CanvasLayer

@onready var pause_screen: Control = $Control/PauseScreen
@onready var system: Control = $Control/System

@onready var system_menu_button: Button = $Control/PauseScreen/SystemMenuButton
@onready var return_to_game: Button = $Control/PauseScreen/ReturnToGame

@onready var music: HSlider = $Control/System/VBoxContainer/HBoxContainer/MusicSlider
@onready var return_to_menu: Button = $Control/System/VBoxContainer/HBoxContainer2/ReturnToMenu

var music_bus: int

func _ready() -> void:
	music_bus = AudioServer.get_bus_index("Music")
	if music_bus == -1:
		push_error("No audio bus named 'Music' exists!")

	system_menu_button.pressed.connect(show_system_menu)
	return_to_menu.pressed.connect(show_pause_screen)
	setup_system_menu()
	show_pause_screen()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_viewport().set_input_as_handled()
		get_tree().paused = false
		queue_free()

func show_pause_screen() -> void:
	pause_screen.show()
	system.hide()

func show_system_menu() -> void:
	system.show()
	pause_screen.hide()

func setup_system_menu() -> void:
	music.min_value = 0.0
	music.max_value = 1.0
	music.step = 0.01
	music.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	music.value_changed.connect(_on_music_slider_changed)

func _on_music_slider_changed(v: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(v))
	AudioServer.set_bus_mute(music_bus, v < 0.01)
