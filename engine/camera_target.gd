extends Node3D

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	global.connect("new_player_added", _on_new_player_added)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		global_position = player.global_position

func _on_new_player_added():
	player = global.players[0]
