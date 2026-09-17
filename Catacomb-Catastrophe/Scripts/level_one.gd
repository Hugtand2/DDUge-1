extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Levels.setup()
	$Camera2D/LevelViewportUI/RetryLabel.show()
<<<<<<< Updated upstream
	$Camera2D/LevelViewportUI/ArrowkeyLabel.show()
=======
	$Camera2D/LevelViewportUI/ArrowKeyLabel.show()
>>>>>>> Stashed changes
	pass # Replace with function body.

func remove(button: Button) -> void:
	button.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
