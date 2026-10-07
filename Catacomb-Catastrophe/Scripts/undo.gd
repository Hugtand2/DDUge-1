extends Node

var state := {}
@onready var Sarc: StaticBody2D = $"../Sarcophagus"
var state_sarc_dir
var state_sarc_pos
var state_sarc_rot
var state_current_rot
var state_upright


func _ready() -> void:
	pass


func save_state() -> void:
	print("Saving state...")
	for object in get_tree().get_nodes_in_group("UndoObjects"):
		state[object.name] = object.global_position
	state_sarc_dir = Sarc.sarc_dir
	state_sarc_pos = Sarc.position
	state_sarc_rot = Sarc.rotation
	state_upright = Sarc.upright
	state_current_rot = Sarc.current_rotation
	print(state_sarc_dir)
	print(state_sarc_pos)
	print(state_sarc_rot)
	print(state_current_rot)
	print(state_upright)


func load_state() -> void:
	for object in get_tree().get_nodes_in_group("UndoObjects"):
		if state.has(object.name):
			object.global_position = state[object.name]
		Sarc.sarc_dir = state_sarc_dir
		Sarc.position = state_sarc_pos
		Sarc.rotation = state_sarc_rot
		Sarc.upright = state_upright
		Sarc.current_rotation = state_current_rot
		print(state)
		state = {}
		
