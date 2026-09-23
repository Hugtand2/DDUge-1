extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UI/SkipLabel.show()
	$UI/RetryLabel.hide()
	$UI/MoveCount.hide()
	$AnimationPlayer.play("Cutscene")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		SceneManager.change_scene("res://Scenes/LevelOne.tscn")
	pass


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	SceneManager.change_scene("res://Scenes/LevelOne.tscn")
	pass # Replace with function body.
