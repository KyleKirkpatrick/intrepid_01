extends RigidBody3D

@export var impulse_speed = 10
@export var thrust_speed = 100
@export var boost_speed = 1000
@export var max_torque = 10  # Maximum torque that can be applied
@export var damping_threshold = 0.1  # Threshold for applying damping
@export var damping_factor = 0.5  # Damping factor

@onready var coordinate_label = $camera_2d/container/coordinate_label

#rotational PID controller
var target_direction = Vector3(0,1,0)
var pid = Vector3()  # PID controller for each axis

# PID constants
var kp = 1.0  # Proportional gain
var ki = 0.0  # Integral gain
var kd = 0.0 # Derivative gain

func _ready():
	global.new_player()

func _physics_process(delta):
	var input_direction = Input.get_vector("steer_left", "steer_right", "steer_up", "steer_down")
	if input_direction != Vector2.ZERO:
		target_direction = Vector3(input_direction.x, -input_direction.y, 0).normalized()
	rotate_toward_direction(target_direction, delta)
	
	if Input.is_action_pressed("thrust_left"):
		var trigger_strength = Input.get_action_strength("thrust_left")
		apply_central_impulse(transform.basis.y * thrust_speed * delta)

func rotate_toward_direction(target_direction, delta):
	var current_direction = transform.basis.y
	var error = target_direction.cross(current_direction)
	
	# Calculate PID
	var p = error
	var i = pid + error * delta
	var d = (error - pid) / delta
	
	# Limit the integral term to prevent windup
	i = clamp_vector3(i, -max_torque, max_torque)
	pid = i
	
	# Calculate torque
	var torque = -kp * p - ki * i - kd * d
	
	# Check if damping should be applied
	var angle = current_direction.angle_to(target_direction)
	if angle < damping_threshold:
		torque -= damping_factor * angular_velocity  # Apply damping torque
	
	# Apply torque
	apply_torque_impulse(clamp_vector3(torque, -max_torque, max_torque))

# Custom function to clamp a Vector3
func clamp_vector3(vec, min_val, max_val):
	return Vector3(
		clamp(vec.x, min_val, max_val),
		clamp(vec.y, min_val, max_val),
		clamp(vec.z, min_val, max_val)
	)
