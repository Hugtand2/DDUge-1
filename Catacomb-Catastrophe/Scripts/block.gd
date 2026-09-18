extends StaticBody2D
 
const tile_size: Vector2 = Vector2(16, 16)
var is_moving: bool = false
 
@export var pushable := true
@export var maxPushes := -1
 
@onready var ray_cast_2d: RayCast2D = $RayCast2D
 
 
func _ready() -> void:
	ray_cast_2d.enabled = pushable
 
 
# Returns true if this object successfully moved (or was clear to move),
# false if it's blocked and could not be pushed.
func push_block(dir: Vector2, raycast: RayCast2D) -> bool:
	if is_moving or not pushable:
		return false
 
	ray_cast_2d.target_position = dir * tile_size
	ray_cast_2d.force_raycast_update()
 
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		# If what's in the way is itself pushable, try to push it first.
		if collider and collider.has_method("push_block"):
			if not collider.push_block(dir, ray_cast_2d):
				return false
		else:
			# Blocked by something that isn't pushable (wall, etc.)
			return false
 
	_move_animation(global_position + dir * tile_size)
	return true
 
 
func _move_animation(targetPosition):
	is_moving = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", targetPosition, 0.185).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(func(): is_moving = false)
 
