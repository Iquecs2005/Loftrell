extends Node2D

signal OnMoveSignal(inputVector)
signal OnItemSignal(itemID : int)

var itemVector : Array = ["Item1","Item2",]
@export var maxItems : int

var moveVector : Vector2 = Vector2.ZERO
var onMove : bool = false

func _process(_delta: float) -> void:
	ProcessMovement()
	ProcessoItems()

func ProcessMovement():
	if (Input.is_action_just_pressed("MoveUp")):
		moveVector.y -= 1
		onMove = true
	elif (Input.is_action_just_released("MoveUp")):
		moveVector.y += 1
		onMove = true
	
	if (Input.is_action_just_pressed("MoveDown")):
		moveVector.y += 1
		onMove = true
	elif (Input.is_action_just_released("MoveDown")):
		moveVector.y -= 1
		onMove = true
	
	if (Input.is_action_just_pressed("MoveRight")):
		moveVector.x += 1
		onMove = true
	elif (Input.is_action_just_released("MoveRight")):
		moveVector.x -= 1
		onMove = true
	
	if (Input.is_action_just_pressed("MoveLeft")):
		moveVector.x -= 1
		onMove = true
	elif (Input.is_action_just_released("MoveLeft")):
		moveVector.x += 1
		onMove = true

	if onMove:
		OnMove()
		onMove = false

func OnMove():
	OnMoveSignal.emit(moveVector)
	pass

func ProcessoItems():
	for i in range(0, maxItems):
		if (Input.is_action_just_pressed("Item"+str(i))):
			OnItemSignal.emit(i)
