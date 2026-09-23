extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Levels.setup()
	$UI/RetryLabel.show()
	$UI/ArrowkeyLabel.show()
	$UI/SkipLabel.hide()
	#$Camera2D/LevelViewportUI/RetryLabel.show()
	#$Camera2D/LevelViewportUI/ArrowkeyLabel.show()

func remove(button: Button) -> void:
	#button.visible = false
	pass
