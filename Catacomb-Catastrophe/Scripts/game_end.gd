extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicPlayer.stop()
	MusicPlayer.play_custom_track("res://Music/egyptian swag.mp3")
	$AnimatedSprite2D.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
