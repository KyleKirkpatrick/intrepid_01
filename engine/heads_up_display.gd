extends Camera2D

@onready var coordinate_label = $container/coordinate_label

var run_updates = false

# Called when the node enters the scene tree for the first time.
func _ready():
	delay_run_updates()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if run_updates:
		update_HUD()

func delay_run_updates():
	await get_tree().create_timer(1.0).timeout
	run_updates = true

func update_HUD():
	if global.players:
		var player = global.players[0]
		var coordinates = player.global_position
		coordinate_label.clear()
		coordinate_label.append_text("Velocity: " + str(player.linear_velocity) + "\n")
		coordinate_label.append_text("X: " + str(roundf(coordinates.x)) + "\n")
		coordinate_label.append_text("Y: " + str(roundf(coordinates.y)))
