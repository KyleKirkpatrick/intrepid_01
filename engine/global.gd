extends Node

signal new_player_added

@export var scenes: Array[PackedScene]

var players: Array[Node]

func _enter_tree():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func new_player():
	players = get_tree().get_nodes_in_group("player")
	new_player_added.emit()
