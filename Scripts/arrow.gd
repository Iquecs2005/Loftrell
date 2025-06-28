extends Node2D

var playerRef : Node

var initialPosition : Vector2

@export var arrowSpeed : float

var dirVector : Vector2

func initialize(player : Node, newDir : Vector2) -> void:
	initialPosition = global_position
	dirVector = newDir
	playerRef = player
	

func _physics_process(_delta: float) -> void:
	global_position += dirVector * arrowSpeed

func destroyArrow(body: Node2D) ->void:
	if (body != playerRef):
		if body.get("damageController"):
			var damageController = body.damageController
			if damageController != null:
				damageController.DamageTarget(2)
		playerRef.ArrowTimeout()
		get_parent().queue_free()
