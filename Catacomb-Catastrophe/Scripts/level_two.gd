extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Levels.setup()
	$UI/ArrowkeyLabel.hide()
	#$Camera2D/LevelViewportUI/ArrowkeyLabel.hide()
	#pass # Replace with function body.
