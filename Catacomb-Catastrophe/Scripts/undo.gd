extends Node

var history: Array[Dictionary] = []
@onready var Sarc: StaticBody2D = $"../Sarcophagus"


func save_state() -> void:
	print("Saving state...")
	var snapshot := {}  # fresh dictionary every time

	var objects := {}
	for object in get_tree().get_nodes_in_group("UndoObjects"):
		objects[object.name] = object.global_position
	snapshot["objects"] = objects

	snapshot["sarc"] = {
		"dir": Sarc.sarc_dir,
		"pos": Sarc.position,
		"rot": Sarc.rotation,
		"upright": Sarc.upright,
		"current_rot": Sarc.current_rotation,
	}

	history.append(snapshot)


func load_state() -> void:
	if history.is_empty():
		return

	# The last entry is the state from just before the latest move
	var snapshot: Dictionary = history.pop_back()

	for object in get_tree().get_nodes_in_group("UndoObjects"):
		if snapshot["objects"].has(object.name):
			object.global_position = snapshot["objects"][object.name]

	var s: Dictionary = snapshot["sarc"]
	Sarc.sarc_dir = s["dir"]
	Sarc.position = s["pos"]
	Sarc.rotation = s["rot"]
	Sarc.upright = s["upright"]
	Sarc.current_rotation = s["current_rot"]
