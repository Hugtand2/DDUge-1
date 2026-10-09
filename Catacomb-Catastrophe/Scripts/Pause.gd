class_name PauseMenu extends CanvasLayer

@onready var pause_screen: Control = $Control/PauseScreen
@onready var system: Control = $Control/System

@onready var system_menu_button: Button = $Control/PauseScreen/SystemMenuButton
@onready var return_to_game: Button = $Control/PauseScreen/ReturnToGame

@onready var music: HSlider = $Control/System/VBoxContainer/HBoxContainer/Music
@onready var return_to_menu: Button = $Control/System/VBoxContainer/HBoxContainer2/ReturnToMenu

func _ready() -> void:
	show_pause_screen()
	system_menu_button.pressed.connect(show_system_menu)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_viewport().set_input_as_handled()
		get_tree().paused = false
		queue_free()

func show_pause_screen() -> void:
	if system.visible:
		pause_screen.show()
		system.hide()


func show_system_menu() -> void:
	if pause_screen.visible:
		system.show()
		pause_screen.hide()
	if return_to_menu.pressed.connect(show_pause_screen):
		return

func setup_system_menu() -> void:
	music.slider.value = AudioServer.get_bus_volume_linear(0)
	
	music.slider.value_changed.connect(_on_music_slider_changed)

func _on_music_slider_changed(v:float) -> void:
	AudioServer.set_bus_volume_linear(0,v)
