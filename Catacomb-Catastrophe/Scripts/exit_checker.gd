extends Node2D

@onready var ExitRaycast: RayCast2D = $ExitRaycast
@onready var Sarc: StaticBody2D = $"../Sarcophagus"
@export var next_level_path: String
@onready var next: Button = $"../UI/NextLevelButton"
@onready var retry: Button = $"../UI/RetryButton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sarc.block_moved_exit_check.connect(exit_checks)
	next.pressed.connect(on_next_level_button_pressed)
	retry.pressed.connect(on_retry_button_pressed)

func exit_checks() -> void:
	print("Exit checked")
	if ExitRaycast.is_colliding():
		print("Level Won! Bring up UI now")
		next.show()
		retry.show()


func on_retry_button_pressed() -> void:
	Levels.reset_level()
	
	
func on_next_level_button_pressed() -> void:
	SceneManager.change_scene(next_level_path)
