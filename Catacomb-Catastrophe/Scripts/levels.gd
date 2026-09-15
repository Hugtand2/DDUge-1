extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called when the level is cleared
func level_clear() -> void:
	pass

# Called upon user input
func reset_level() -> void:
	SceneManager.change_scene(get_tree().current_scene.scene_file_path)
	pass
