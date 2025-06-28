class_name PlayerScript
extends RigidBody2D

@onready var healthController = $HealthController
@onready var damageController = $DamageController

@onready var bombTimer = $BombTimer
@onready var attackTimer = $AttackTimer
@onready var shieldTimer = $ShieldTimer

@onready var attackArea = $AttackArea

@export var maxSpeed : float
@export var acceleration : float
@export var desaceleration : float
@export var minimumInputVector : float

@export var bombPrefab : PackedScene
@export var bombDamage : float
@export var bombRadius : float
@export var hookPrefab : PackedScene
@export var arrowPrefab : PackedScene

@export var attackSprite : AnimatedSprite2D
@export var attackCollision = CollisionShape2D

var lockRotation : bool = false
var shouldMove : bool = true

@export var raycast : RayCast2D
@export var shieldRaycast : RayCast2D

var shouldAccelerate : bool
var shouldDesaccelerate : bool

var inputVector : Vector2 = Vector2.ZERO
var facingDir = Vector2.DOWN

@export var bombOfsset = 0
@export var hookOffset = 0
@export var arrowOffset = 0

var bombCooldown : bool = true
var itemCooldown : bool = true
var shieldCooldown : bool = true
var arrowCooldown : bool = true

var isDefending : bool = false

var hasSword : bool = true
var hasShield : bool = true
var hasBow : bool = true
var hasBomb : bool = true
var hasHookshot : bool = true

func _physics_process(_delta: float) -> void:
	
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
	
	attackArea.position = facingDir * 10
	raycast.target_position = facingDir * 15
	shieldRaycast.target_position = facingDir * 30

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
	if !itemCooldown || !hasSword :
		print("Gancho em cooldown")
		return
	#attackSprite.play("attack")
	attackCollision.disabled = false
	StopMovement()
	print("Usou sua espada")
	itemCooldown = false
	attackTimer.start()

func RaiseShield():
	if !shieldCooldown || !itemCooldown || !hasShield :
		print("Gancho em cooldown")
		return
	shieldRaycast.enabled = true
	shieldRaycast.force_raycast_update()
	if shieldRaycast.is_colliding():
		isDefending = true
	shieldRaycast.enabled = false
	shieldCooldown = false
	shieldTimer.start()
	print("Usou seu escudo")

func ShootBow():
	if !arrowCooldown || !itemCooldown || !hasBow :
		print("Gancho em cooldown")
		return
	arrowCooldown = false
	var newArrow = arrowPrefab.instantiate()
	newArrow.global_position = global_position + facingDir * arrowOffset
	newArrow.get_child(0).rotation = facingDir.angle()
	get_tree().root.add_child(newArrow)
	newArrow.get_child(0).initialize(self, facingDir)
	print("Usou seu arco")

func DropBomb():
	if !bombCooldown || !itemCooldown || !hasBomb :
		print("Bomba em cooldown")
		return
	raycast.enabled = true
	raycast.force_raycast_update()
	var newBomb = bombPrefab.instantiate()
	newBomb.Initialize(bombDamage, bombRadius)
	newBomb.global_position = global_position + facingDir * bombOfsset
	if raycast.is_colliding():
		newBomb.global_position = global_position
	raycast.enabled = false
	get_tree().root.add_child(newBomb)
	print("Usou sua bomba")
	bombCooldown = false
	bombTimer.start()

func ShootHookshot():
	if !itemCooldown || !hasHookshot :
		print("Gancho em cooldown")
		return
	var newHookshoot = hookPrefab.instantiate()
	newHookshoot.global_position = global_position + facingDir * hookOffset
	newHookshoot.get_child(0).rotation = facingDir.angle()
	get_tree().root.add_child(newHookshoot)
	newHookshoot.get_child(0).initialize(self, facingDir)
	StopMovement()
	print("Usou seu gancho")
	itemCooldown = false

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

func ItemTimeout() -> void:
	itemCooldown = true
	
func AttackTimeout() -> void:
	#attackSprite.play("default")
	attackCollision.disabled = true
	ResumeMovement()
	itemCooldown = true
	
func ShieldTimeout() -> void:
	shieldCooldown = true
	isDefending = false
	
func ArrowTimeout() -> void:
	arrowCooldown = true

func Destroy() -> void:
	get_tree().change_scene_to_file("res://Scenes/overworld.tscn")

func OnSceneTransition(destination : Node2D):
	StopMovement()
	
	var dirVector = destination.global_position - global_position
	if abs(dirVector.x) > abs(dirVector.y):
		dirVector.y = 0
	else:
		dirVector.x = 0
	dirVector = dirVector.normalized()
	
	linear_velocity = dirVector * maxSpeed
	return

func EndSceneTransition():
	ResumeMovement()
	return

func Attack(body: Node2D) -> void:
	if (body != self):
		var damageController = body.damageController
		if damageController != null:
			damageController.DamageTarget(2)
		print("atacou")
