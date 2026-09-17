extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered() -> void:
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group():
			Levels.level_clear()
	pass
