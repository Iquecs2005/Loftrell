class_name WorldTile
extends Node2D

@export var initialTile : bool

@export var colliders : Array[MapBorder]
@export var enemys : Array[Node2D]
@export var Props : Array[Node2D]

func _ready() -> void:
	SetActive(initialTile)

func SetColliderActive(enabled : bool):
	for MapBorderScript in colliders:
		MapBorderScript.SetActive(enabled)

func EnableEnemys(enabled : bool):
	for enemy in enemys:
		enemy.SetActive(enabled)
	return

func ResetProps():
	for prop in Props:
		prop.Reset()

func SetActive(state: bool):
	SetColliderActive(state)
	EnableEnemys(state)
	if state == true:
		ResetProps()
	return
