class_name MapBorder
extends Node2D

var enabled : bool

@export var destination : Node2D

func SetActive(state: bool):
	state = enabled
	$StaticBody2D.monitoring = state
	return

func onCollisionEntered(body: Node2D) -> void:
	print('a')
	CameraController.instance.setDestination(destination)
	pass # Replace with function body.
