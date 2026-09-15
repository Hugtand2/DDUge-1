extends StaticBody2D

const tile_size: Vector2 = Vector2(16, 16)

var is_rotated: bool = false
var is_moving: bool = false
var upright: bool = true

@export var pushable := true
@export var maxPushes := -1
@export var dimentions: Vector2i
@export var player: CharacterBody2D

@onready var ray_cast_2d_lower: RayCast2D = $Raycasts/RayCast2DLower
@onready var ray_cast_2d_upper: RayCast2D = $Raycasts/RayCast2DUpper

func _ready() -> void:
	ray_cast_2d_lower.enabled = pushable
	ray_cast_2d_upper.enabled = pushable
	
func push_block(dir: Vector2, raycast: RayCast2D):
	if is_moving or not pushable:
		return
	
	ray_cast_2d_lower.target_position = dir * tile_size
	ray_cast_2d_upper.target_position = dir * tile_size
	
	ray_cast_2d_lower.force_raycast_update()
	ray_cast_2d_upper.force_raycast_update()
	
	
	# Moves only if you push from the top or bottom of the sarcophagus
	if upright:
		if dir.y != 0:
			if not pushable or ray_cast_2d_lower.is_colliding() or ray_cast_2d_upper.is_colliding():
				return
			_move_animation(global_position + dir * tile_size)
		else:
			push_and_rotate(dir, raycast)
	else:
		if dir.x != 0:
			if not pushable or ray_cast_2d_lower.is_colliding() or ray_cast_2d_upper.is_colliding():
				return
			_move_animation(global_position + dir * tile_size)
		else:
			push_and_rotate(dir, raycast)
	
	
	
func _move_animation(targetPosition):
	is_moving = true
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position", targetPosition, 0.185).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(func(): is_moving = false)

func push_and_rotate(dir: Vector2, raycast: RayCast2D) -> void:
	if raycast == player.get_node("right"):
		if raycast.target_position == ray_cast_2d_upper.target_position - Vector2(16, 0):
			print("Push from upperleft")
			return
		if raycast.target_position == ray_cast_2d_lower.target_position - Vector2(16, 0):
			print("Push from lowerleft")
			return
	else:
		if raycast.target_position == ray_cast_2d_upper.target_position - Vector2(16, 0):
			print("Push from upperright")
			return
		if raycast.target_position == ray_cast_2d_lower.target_position - Vector2(16, 0):
			print("Push from lowerright")
			return


func do_rotation() -> void:
	is_rotated = !is_rotated
	dimentions = Vector2i(dimentions.y,dimentions.x)
	var tween = create_tween()
	tween.tween_property(self,"rotation_degrees", 90 if is_rotated else 0, 0.185)
