extends RigidBody2D

@export var explosionCollider : CollisionShape2D

func ExplodeBomb():
	explosionCollider.disabled = false

func _on_explosion_area_body_entered(body: Node2D) -> void:
	var damageController = body.damageController
	
	if damageController != null:
		print("I DONT KNOW WHAT IM DOING")
	
	pass # Replace with function body.
