extends RigidBody2D

@export var maxMoveSpeed : float
@export var acceleration : float
@export var desaceleration : float
@export var damage : int 

var PlayerRef : Node2D

var onCooldown : bool = false
var resetPos : bool = false
var shouldMove : bool = false
var isDead : bool = false
var initialPosition : Vector2

func _ready() -> void:
	
	PlayerRef = get_tree().root.get_node("./Overworld/Player")
	initialPosition = global_position
	
	return

func _physics_process(delta: float) -> void:
	Move()

func Move():
	if !shouldMove or PlayerRef == null:
		return
	
	var dirVector : Vector2 = (PlayerRef.global_position - global_position).normalized()
	
	var targetSpeed : Vector2 = dirVector * maxMoveSpeed
	var speedDif : Vector2 = targetSpeed - linear_velocity
	
	var accelRate
	if (targetSpeed.length() > 0.01):
		accelRate = acceleration
	else:
		accelRate = desaceleration
	
	apply_central_force(accelRate * speedDif)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if (resetPos):
		global_position = initialPosition
		linear_velocity = Vector2.ZERO
		resetPos = false

func SetActive(state):
	
	resetPos = true
	shouldMove = state
	
	if (state and isDead):
		Respawn()
	
	return

func Respawn():
	isDead = false
	
	return

func _on_body_entered(body: Node) -> void:
	print("e")
	if body.name == "Player" && !onCooldown:
		print("d")
		onCooldown = true
		$AttackCooldown.start()
		body.damageController.DamageTarget(damage)
		
func OnTimerEnd():
	onCooldown = false
