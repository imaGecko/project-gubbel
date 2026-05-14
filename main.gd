extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level = load("res://test_level.tscn")
	var instance = level.instantiate()
	add_child(instance)
	var spawn = get_node("level/Spawn")
	$Player.position = spawn.position
