extends Node2D

@export var destination : Node2D

func onCollisionEntered(body: Node2D) -> void:
	print('a')
	CameraController.instance.setDestination()
	pass # Replace with function body.
