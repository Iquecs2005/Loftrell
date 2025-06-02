extends RigidBody2D

@export var maxSpeed : float
@export var acceleration : float
@export var desaceleration : float
@export var minimumInputVector : float

@export var bombPrefab : PackedScene
@export var hookPrefab : PackedScene

var shouldAccelerate : bool
var shouldDesaccelerate : bool

var inputVector : Vector2 = Vector2.ZERO
var facingDir = Vector2.DOWN

@export var bombOfsset = 0
@export var hookOffset = 0

@export var bombTimer : Timer

var bombCooldown = true

func _physics_process(delta: float) -> void:
	Move()
	#HandleMovement(delta)

func OnMoveInputChange(newInputVector : Vector2):
	inputVector = newInputVector
	if (inputVector.length() > 1):
		inputVector = inputVector.normalized()
	
	if abs(inputVector.x) > abs(inputVector.y):
		if inputVector.x > 0:
			facingDir = Vector2.RIGHT
		elif inputVector.x < 0: 
			facingDir = Vector2.LEFT
	else:
		if inputVector.y > 0:
			facingDir = Vector2.DOWN
		elif inputVector.y < 0: 
			facingDir = Vector2.UP

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

func SwingSword():
	print("Usou sua espada")

func RaiseShield():
	print("Usou seu escudo")

func ShootBow():
	print("Usou seu arco")

func DropBomb():
	if !bombCooldown :
		print("Bomba em cooldown")
		return
	var newBomb = bombPrefab.instantiate()
	newBomb.global_position = global_position + facingDir * bombOfsset
	get_tree().root.add_child(newBomb)
	print("Usou sua bomba")
	bombCooldown = false
	bombTimer.start()

func ShootHookshot():
	var newHookshoot = hookPrefab.instantiate()
	newHookshoot.global_position = global_position + facingDir * hookOffset
	get_tree().root.add_child(newHookshoot)
	newHookshoot.get_child(0).initialize(facingDir)
	print("Usou seu gancho")


func BombTimeout() -> void:
	bombCooldown = true
