extends RigidBody3D

@export var impulse_speed = 1
@export var thrust_speed = 10
@export var boost_speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_direction = Input.get_vector("steer_left", "steer_right", "steer_up", "steer_down")
	var direction = Vector3(input_direction.x, -input_direction.y, 0).normalized()
	if direction:
		apply_central_force(direction * impulse_speed)
