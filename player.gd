extends RigidBody2D

@export var maxSpeed : float
@export var acceleration : float
@export var desaceleration : float
@export var minimumInputVector : float

var shouldAccelerate : bool
var shouldDesaccelerate : bool

var inputVector : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	Move()
	#HandleMovement(delta)

func OnMoveInputChange(newInputVector : Vector2):
	inputVector = newInputVector

func Move():
	var targetSpeed : Vector2 = inputVector * maxSpeed
	var speedDif : Vector2 = targetSpeed - linear_velocity
	
	var accelRate
	if (targetSpeed.length() > 0.01):
		accelRate = acceleration
	else:
		accelRate = desaceleration
	
	apply_central_force(accelRate * speedDif)

#func HandleMovement(delta: float):
	#currentVelocity += currentAcceleration * delta
	#position += currentVelocity * delta
