extends RigidBody2D

@onready var healthController = $HealthController
@onready var damageController = $DamageController

@export var maxSpeed : float
@export var acceleration : float
@export var desaceleration : float
@export var minimumInputVector : float

@export var bombPrefab : PackedScene
@export var hookPrefab : PackedScene

@export var attackSprite : AnimatedSprite2D
@export var attackCollision = CollisionShape2D

var lockRotation : bool = false
var shouldMove : bool = true

@export var raycast : RayCast2D

var shouldAccelerate : bool
var shouldDesaccelerate : bool

var inputVector : Vector2 = Vector2.ZERO
var facingDir = Vector2.DOWN

@export var bombOfsset = 0
@export var hookOffset = 0

@export var bombTimer : Timer
@export var attackTimer : Timer

var bombCooldown = true
var hookCooldown = true

func _physics_process(delta: float) -> void:
	
	Move()
	#HandleMovement(delta)

func OnMoveInputChange(newInputVector : Vector2):
	inputVector = newInputVector
	if (inputVector.length() > 1):
		inputVector = inputVector.normalized()
	
	calculateRotation()

func calculateRotation():
	if (lockRotation):
		return
	
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
	raycast.target_position = facingDir * 15

func Move():
	if !shouldMove:
		return
	
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
	if !hookCooldown :
		print("Gancho em cooldown")
		return
	attackSprite.visible = true
	attackCollision.disabled = false
	StopMovement()
	print("Usou sua espada")
	hookCooldown = false
	attackTimer.start()

func RaiseShield():
	if !hookCooldown :
		print("Gancho em cooldown")
		return
	print("Usou seu escudo")

func ShootBow():
	if !hookCooldown :
		print("Gancho em cooldown")
		return
	print("Usou seu arco")

func DropBomb():
	if !hookCooldown :
		print("Gancho em cooldown")
		return
	if !bombCooldown:
		print("Bomba em cooldown")
		return
	raycast.enabled = true
	raycast.force_raycast_update()
	var newBomb = bombPrefab.instantiate()
	newBomb.global_position = global_position + facingDir * bombOfsset
	if raycast.is_colliding():
		newBomb.global_position = global_position
	raycast.enabled = false
	get_tree().root.add_child(newBomb)
	print("Usou sua bomba")
	bombCooldown = false
	bombTimer.start()

func ShootHookshot():
	if !hookCooldown :
		print("Gancho em cooldown")
		return
	var newHookshoot = hookPrefab.instantiate()
	newHookshoot.global_position = global_position + facingDir * hookOffset
	newHookshoot.get_child(0).rotation = facingDir.angle()
	get_tree().root.add_child(newHookshoot)
	newHookshoot.get_child(0).initialize(self, facingDir)
	StopMovement()
	print("Usou seu gancho")
	hookCooldown = false

func StopMovement():
	shouldMove = false
	lockRotation = true
	linear_velocity = Vector2.ZERO

func ResumeMovement():
	shouldMove = true
	lockRotation = false
	calculateRotation()

func BombTimeout() -> void:
	bombCooldown = true

func HookTimeout() -> void:
	hookCooldown = true
	
func AttackTimeout() -> void:
	attackSprite.visible = false
	attackCollision.disabled = true
	ResumeMovement()
	hookCooldown = true
