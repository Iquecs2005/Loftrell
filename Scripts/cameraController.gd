class_name CameraController
extends Camera2D

static var instance : CameraController

@export var destination : Node2D
@export var movementDuration : float

var initialDestination : Vector2
var moving : bool = false
var timeMoving : float

func _init() -> void:
	
	if(instance != null):
		instance.queue_free()
		
	instance = self;
	
	return

func _physics_process(delta: float) -> void:
	if moving:
		applyMovement(delta)
	return

func setDestination(newDestination : Node2D):
	
	if moving:
		return
	
	print('b')
	timeMoving = 0
	initialDestination = global_position
	destination = newDestination
	moving = true
	
	return

func applyMovement(delta: float):
	timeMoving += delta
	var completionRatio = timeMoving / movementDuration
	
	var CameraPosWeight = smoothstep(0, 1, completionRatio)
	
	var CameraXCord = destination.position.x * CameraPosWeight + initialDestination.x * (1 - CameraPosWeight)
	var CameraYCord = destination.position.y * CameraPosWeight + initialDestination.y * (1 - CameraPosWeight)
	
	global_position = Vector2(CameraXCord, CameraYCord) 
	
	if (completionRatio >= 1):
		global_position = destination.position
		moving = false
	
	return
