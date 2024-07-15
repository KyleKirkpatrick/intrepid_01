extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var first_scene = global.scenes[0].instantiate()
	get_node("sub_viewport_container/sub_viewport").add_child(first_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
