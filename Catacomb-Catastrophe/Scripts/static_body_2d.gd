extends StaticBody2D

const tile_size: Vector2 = Vector2(16, 16)

var is_rotated: bool = false
var is_moving: bool = false

@export var sarc_dir: Vector2
var upright: bool = true


@export var pushable := true
@export var maxPushes := -1
@export var dimentions: Vector2i
@export var player: CharacterBody2D

@onready var ray_cast_2d_lower: RayCast2D = $Raycasts/RayCast2DLower
@onready var ray_cast_2d_upper: RayCast2D = $Raycasts/RayCast2DUpper

func _ready() -> void:
	if sarc_dir == Vector2(1,0) or sarc_dir == Vector2(-1,0):
		upright = false
	ray_cast_2d_lower.enabled = pushable
	ray_cast_2d_upper.enabled = pushable
	
func push_block(dir: Vector2, raycast: RayCast2D):
	if is_moving or not pushable:
		return
	if sarc_dir == Vector2(0,-1):
		ray_cast_2d_lower.target_position = dir * tile_size
		ray_cast_2d_upper.target_position = dir * tile_size
	elif sarc_dir == Vector2(1,0):
		ray_cast_2d_upper.target_position = Vector2((dir.y), -(dir.x)) * tile_size
		ray_cast_2d_lower.target_position = Vector2((dir.y), -(dir.x)) * tile_size
	elif sarc_dir == Vector2(0,1):
		ray_cast_2d_upper.target_position = -Vector2(dir.x, dir.y) * tile_size
		ray_cast_2d_lower.target_position = -Vector2(dir.x, dir.y) * tile_size
	else:
		ray_cast_2d_upper.target_position = -Vector2((dir.y), -(dir.x)) * tile_size
		ray_cast_2d_lower.target_position = -Vector2((dir.y), -(dir.x)) * tile_size
	
	ray_cast_2d_lower.force_raycast_update()
	ray_cast_2d_upper.force_raycast_update()
	
	
	# Moves only if you push from the top or bottom of the sarcophagus
	if upright:
		if dir.y != 0:
			if ray_cast_2d_lower.is_colliding() or ray_cast_2d_upper.is_colliding():
				return
			_move_animation(global_position + dir * tile_size)
		else:
			push_and_rotate(raycast)
	else:
		if dir.x != 0:
			if ray_cast_2d_lower.is_colliding() or ray_cast_2d_upper.is_colliding():
				return
			_move_animation(global_position + dir * tile_size)
		else:
			push_and_rotate(raycast)
	
	
func _move_animation(targetPosition):
	is_moving = true
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position", targetPosition, 0.185).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(func(): is_moving = false)

func push_and_rotate(raycast: RayCast2D) -> void:
	var offset = player.global_position - global_position
	if sarc_dir == Vector2(0, -1):
		if raycast == player.get_node("right"):
			# Player is pushing from the left side
			if offset.y < 0:
				print("upper-left")
				do_rotation(current_rotation + 90)
			else:
				print("lower-left")
				do_rotation(current_rotation - 90)
		else:
			# Player is pushing from the rihgt side
			if offset.y < 0:
				print("upper-right")
				do_rotation(current_rotation - 90)
			else:
				print("lower-right")
				do_rotation(current_rotation + 90)
	elif sarc_dir == Vector2(1, 0):
		if raycast == player.get_node("up"):
			# Player is pushing from the lower side
			if offset.x < 0:
				print("lower-right")
				do_rotation(current_rotation + 90)
			else:
				print("upper-right")
				do_rotation(current_rotation - 90)
		else:
			# Player is pushing from the rihgt side
			if offset.x < 0:
				print("lower-left")
				do_rotation(current_rotation - 90)
			else:
				print("upper-left")
				do_rotation(current_rotation + 90)
	elif sarc_dir == Vector2(0, 1):
		if raycast == player.get_node("left"):
			# Player is pushing from the lower side
			if offset.y > 0:
				print("upper-left")
				do_rotation(current_rotation + 90)
			else:
				print("lower-left")
				do_rotation(current_rotation - 90)
		else:
			# Player is pushing from the rihgt side
			if offset.y > 0:
				print("upper-right")
				do_rotation(current_rotation - 90)
			else:
				print("lower-right")
				do_rotation(current_rotation + 90)
	else:
		if raycast == player.get_node("down"):
			# Player is pushing from the lower side
			if offset.x > 0:
				print("lower-right")
				do_rotation(current_rotation + 90)
			else:
				print("upper-right")
				do_rotation(current_rotation - 90)
		else:
			# Player is pushing from the rihgt side
			if offset.x > 0:
				print("lower-left")
				do_rotation(current_rotation - 90)
			else:
				print("upper-left")
				do_rotation(current_rotation + 90)


var current_rotation: int = 0

func do_rotation(current_rotation) -> void:
	is_rotated = !is_rotated
	dimentions = Vector2i(dimentions.y,dimentions.x)
	var tween = create_tween()
	tween.tween_property(self,"rotation_degrees", current_rotation, 0.185)
	upright = not upright
	print(upright)
	print(current_rotation)
	await tween.finished
	tween.kill()
