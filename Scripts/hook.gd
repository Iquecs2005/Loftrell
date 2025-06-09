extends Node2D

var playerRef : Node

var initialPosition : Vector2

@export var hookSpeed : float
@export var hookLenght : float
@export var desctructionTime : float

var hookshootLine : Line2D

var maxLenght : bool
var dirVector : Vector2 = Vector2.RIGHT

func initialize(player : Node, newDir : Vector2) -> void:
	initialPosition = global_position
	dirVector = newDir
	playerRef = player
	if (dirVector.y != 0):
		hookLenght /= 2
	rotate(dirVector.angle())
	hookshootLine = get_parent().get_child(1).get_child(0)
	

func _physics_process(_delta: float) -> void:
	if !maxLenght:
		global_position += dirVector * hookSpeed
		if (global_position - initialPosition).length() > hookLenght:
			global_position = initialPosition + dirVector * hookLenght
			StopHookshoot(null)
		hookshootLine.points[1] = global_position - get_parent().global_position

func StopHookshoot(body : Node):
	maxLenght = true
	$DestructionTimer.start(desctructionTime)

func destroyHookshoot():
	playerRef.ResumeMovement()
	playerRef.HookTimeout()
	get_parent().queue_free()
