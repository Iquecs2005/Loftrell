class_name MapBorder
extends Node2D

@export var destination : Node2D

var enabled : bool
var wtScript : WorldTile

func SetActive(state: bool):
	enabled = state
	$StaticBody2D.set_deferred("monitoring", state)
	wtScript = get_parent()
	return

func onCollisionEntered(body: Node2D) -> void:
	print('a')
	if body.name == "Player":
		var playerScript : PlayerScript = body
		if playerScript != null:
			playerScript.OnSceneTransition(destination)
			CameraController.instance.setDestination(destination)
			wtScript.SetActive(false)
			pass # Replace with function body.
