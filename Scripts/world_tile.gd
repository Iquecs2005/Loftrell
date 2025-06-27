class_name WorldTile
extends Node2D

@export var initialTile : bool

@export var colliders : Array[MapBorder]

func _ready() -> void:
	if initialTile:
		SetColliderActive(true)
		return
	SetColliderActive(false)

func SetColliderActive(enabled : bool):
	for MapBorderScript in colliders:
			MapBorderScript.SetActive(enabled)
