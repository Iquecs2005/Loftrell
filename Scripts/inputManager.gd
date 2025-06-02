extends Node2D

signal OnMoveSignal(inputVector)
signal OnSwordInput()
signal OnShieldInput()
signal OnBowInput()
signal OnBombInput()
signal OnHookInput()

var inputActions : Array = ["SwordAction", "ShieldAction", "BowAction", "BombAction", "HookAction"]
var itemEventsArray : Array = [OnSwordInput, OnShieldInput, OnBowInput, OnBombInput, OnHookInput]

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
	
	if (abs(moveVector.x - newMoveVector.x) > delta or abs(moveVector.y - newMoveVector.y) > delta):
		moveVector = newMoveVector
		OnMove()
	
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
	for i in inputActions.size():
		if (Input.is_action_just_pressed(inputActions[i])):
			itemEventsArray[i].emit()
