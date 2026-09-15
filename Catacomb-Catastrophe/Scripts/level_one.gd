extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicPlayer.play_custom_track("res://Music/Ape Escape 2 ( Panic Pyramid ) Soundtrack  OST.mp3")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
