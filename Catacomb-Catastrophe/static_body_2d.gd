extends StaticBody2D

const tile_size: Vector2 = Vector2(16, 16)

var is_rotated: bool = false

@export var pushable := false
@export var maxPushes := -1
@export var dimentions: Vector2i

@onready var ray_cast_2d: RayCast2D = $RayCast2D

var currentPushCount = 0

func _ready() -> void:
	ray_cast_2d.enabled = pushable
	
func push_block(dir: Vector2):
	ray_cast_2d.target_position = dir * tile_size
	ray_cast_2d.force_raycast_update()
	
	
	if not pushable or ray_cast_2d.is_colliding() or currentPushCount == maxPushes: return
	
	_move_animation(global_position + dir * tile_size)
	
	currentPushCount += 1
	
func _move_animation(targetPosition):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position", targetPosition, 0.185).set_trans(Tween.TRANS_SINE)

func do_rotation() -> void:
	is_rotated = !is_rotated
	dimentions = Vector2i(dimentions.y,dimentions.x)
	var tween = create_tween()
	tween.tween_property(self,"rotation_degrees", 90 if is_rotated else 0, 0.185)
