extends StaticBody2D

const tile_size: Vector2 = Vector2(16, 16)
var is_moving: bool = false

@export var sarc_dir: Vector2
var upright: bool = true


@export var pushable := true
@export var maxPushes := -1
@export var player: CharacterBody2D

@onready var ray_cast_2d_lower: RayCast2D = $Raycasts/RayCast2DLower
@onready var ray_cast_2d_upper: RayCast2D = $Raycasts/RayCast2DUpper
@onready var current_rotation: int = 0

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
	#print("Function start current_rotation: " + str(current_rotation))
	var offset = player.global_position - global_position
	if sarc_dir == Vector2(0, -1):
		if raycast == player.get_node("right"):
			# Player is pushing from the left side
			if offset.y < 0:
				print("upper-left")
				current_rotation += 90
				do_rotation(current_rotation, Vector2(-8, -8))
				sarc_dir = Vector2(1,0)
				#print("Function turn current_rotation: " + str(current_rotation))
			else:
				print("lower-left")
				current_rotation -= 90
				do_rotation(current_rotation, Vector2(-8, 8))
				sarc_dir = Vector2(-1,0)
				#print("Function turn current_rotation: " + str(current_rotation))
		else:
			# Player is pushing from the right side
			if offset.y < 0:
				print("upper-right")
				current_rotation -= 90
				do_rotation(current_rotation, Vector2(8, -8))
				sarc_dir = Vector2(-1,0)
				#print("Function turn current_rotation: " + str(current_rotation))
			else:
				print("lower-right")
				current_rotation += 90
				do_rotation(current_rotation, Vector2(8, 8))
				sarc_dir = Vector2(1,0)
				#print("Function turn current_rotation: " + str(current_rotation))
	elif sarc_dir == Vector2(1, 0):
		if raycast == player.get_node("up"):
			# Player is pushing from the right side
			if offset.x < 0:
				print("lower-right")
				current_rotation += 90
				do_rotation(current_rotation, Vector2(-8, 8))
				sarc_dir = Vector2(0,1)
				#print("Function turn current_rotation: " + str(current_rotation))
			else:
				print("upper-right")
				current_rotation -= 90
				do_rotation(current_rotation, Vector2(8, 8))
				sarc_dir = Vector2(0,-1)
				#print("Function turn current_rotation: " + str(current_rotation))
		else:
			# Player is pushing from the left side
			if offset.x < 0:
				print("lower-left")
				current_rotation -= 90
				do_rotation(current_rotation, Vector2(-8, -8))
				sarc_dir = Vector2(0,-1)
				#print("Function turn current_rotation: " + str(current_rotation))
			else:
				print("upper-left")
				current_rotation += 90
				do_rotation(current_rotation, Vector2(8, -8))
				sarc_dir = Vector2(0,1)
				#print("Function turn current_rotation: " + str(current_rotation))
	elif sarc_dir == Vector2(0, 1):
		if raycast == player.get_node("left"):
			# Player is pushing from the lower side
			if offset.y > 0:
				print("upper-left")
				current_rotation += 90
				do_rotation(current_rotation, Vector2(8, 8))
				sarc_dir = Vector2(-1,0)
				#print("Function turn current_rotation: " + str(current_rotation))
			else:
				print("lower-left")
				current_rotation -= 90
				do_rotation(current_rotation, Vector2(8, -8))
				sarc_dir = Vector2(1,0)
				#print("Function turn current_rotation: " + str(current_rotation))
		else:
			# Player is pushing from the rihgt side
			if offset.y > 0:
				print("upper-right")
				current_rotation -= 90
				do_rotation(current_rotation, Vector2(-8, 8))
				sarc_dir = Vector2(1,0)
				#print("Function turn current_rotation: " + str(current_rotation))
			else:
				print("lower-right")
				current_rotation += 90
				do_rotation(current_rotation, Vector2(-8, -8))
				sarc_dir = Vector2(-1,0)
				#print("Function turn current_rotation: " + str(current_rotation))
	else:
		if raycast == player.get_node("down"):
			# Player is pushing from the lower side
			if offset.x > 0:
				print("lower-right")
				current_rotation += 90
				do_rotation(current_rotation, Vector2(8, -8))
				sarc_dir = Vector2(0,-1)
				#print("Function turn current_rotation: " + str(current_rotation))
			else:
				print("upper-right")
				current_rotation -= 90
				do_rotation(current_rotation, Vector2(-8, -8))
				sarc_dir = Vector2(0,1)
				#print("Function turn current_rotation: " + str(current_rotation))
		else:
			# Player is pushing from the rihgt side
			if offset.x > 0:
				print("lower-left")
				current_rotation -= 90
				do_rotation(current_rotation, Vector2(8, 8))
				sarc_dir = Vector2(0,1)
				#print("Function turn current_rotation: " + str(current_rotation))
			else:
				print("upper-left")
				current_rotation += 90
				do_rotation(current_rotation, Vector2(-8, 8))
				sarc_dir = Vector2(0,-1)
				#print("Function turn current_rotation: " + str(current_rotation))

func do_rotation(current_rotation_param, tween_vector_offset) -> void:
	var tween = create_tween()
	var final_destination = global_position - tween_vector_offset
	tween.tween_property(self,"rotation_degrees", current_rotation_param, 0.185)
	tween.tween_property(self,"position", final_destination, 0.185)
	upright = not upright
	await tween.finished
	tween.kill()
	
