extends StaticBody2D


const tile_size: Vector2 = Vector2(16, 16)
var is_moving: bool = false


@export var pushable := true
@export var maxPushes := -1

@onready var ray_cast_2d: RayCast2D = $RayCast2D


func _ready() -> void:
	ray_cast_2d.enabled = pushable
	
func push_block(dir: Vector2, raycast: RayCast2D):
	if is_moving or not pushable:
		return
	if pushable == true:
		ray_cast_2d.target_position = dir * tile_size
	
	ray_cast_2d.force_raycast_update()

	if dir.y != 0:
			if ray_cast_2d.is_colliding():
				return
			_move_animation(global_position + dir * tile_size)
	else:
		if dir.x != 0:
			if ray_cast_2d.is_colliding():
				return
		_move_animation(global_position + dir * tile_size)

func _move_animation(targetPosition):
	is_moving = true
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position", targetPosition, 0.185).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(func(): is_moving = false)
