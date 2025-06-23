extends Node2D

@export var initialTile : bool

@export var colliders : Array[MapBorder]

func _ready() -> void:
	if initialTile:
		SetColliderActive(true)
		return

func SetColliderActive(enabled : bool):
	for MapBorderScript in colliders:
			MapBorderScript.SetActive(enabled)
