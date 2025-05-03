extends Node2D

signal OnMoveSignal(inputVector)
signal OnItemSignal(itemID : int)

@export var maxItems : int

var moveVector : Vector2 = Vector2.ZERO
var onMove : bool = false
@export var delta : float 

func _process(_delta: float) -> void:
	ProcessMovement()
	ProcessoItems()

func ProcessMovement():
	var newMoveVector : Vector2
	
	newMoveVector.x = Input.get_axis("MoveLeft", "MoveRight")
	if(newMoveVector.x > 0.95):
		newMoveVector.x = 1
	elif (newMoveVector.x < -0.95):
		newMoveVector.x = -1
	
	newMoveVector.y = Input.get_axis("MoveUp", "MoveDown")
	if(newMoveVector.y > 0.95):
		newMoveVector.y = 1
	elif (newMoveVector.y < -0.95):
		newMoveVector.y = -1
	
	if (abs(newMoveVector.x - moveVector.x) < delta && abs(newMoveVector.y - moveVector.y) < delta):
		OnMove()
	
	moveVector = newMoveVector
	#if (Input.is_action_just_pressed("MoveUp")):
		#moveVector.y -= 1
		#onMove = true
	#elif (Input.is_action_just_released("MoveUp")):
		#moveVector.y += 1
		#onMove = true
	#
	#if (Input.is_action_just_pressed("MoveDown")):
		#moveVector.y += 1
		#onMove = true
	#elif (Input.is_action_just_released("MoveDown")):
		#moveVector.y -= 1
		#onMove = true
	#
	#if (Input.is_action_just_pressed("MoveRight")):
		#moveVector.x += 1
		#onMove = true
	#elif (Input.is_action_just_released("MoveRight")):
		#moveVector.x -= 1
		#onMove = true
	#
	#if (Input.is_action_just_pressed("MoveLeft")):
		#moveVector.x -= 1
		#onMove = true
	#elif (Input.is_action_just_released("MoveLeft")):
		#moveVector.x += 1
		#onMove = true
#
	#if onMove:
		#OnMove()
		#onMove = false

func OnMove():
	OnMoveSignal.emit(moveVector)
	pass

func ProcessoItems():
	for i in range(0, maxItems):
		if (Input.is_action_just_pressed("Item"+str(i))):
			OnItemSignal.emit(i)
