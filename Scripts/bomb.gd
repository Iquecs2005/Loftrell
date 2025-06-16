extends RigidBody2D

@export var explosionCollider : CollisionShape2D

var bombDamage : float = 0
var collidedObjects = []

func Initialize(damage : float, radius : float):
	bombDamage = damage
	$ExplosionArea/Radius.shape.radius = radius

func ExplodeBomb():
	explosionCollider.disabled = false
	$ExplosionTimer.start()

func _on_explosion_area_body_entered(body: Node2D) -> void:
	
	if body not in collidedObjects:
		var damageController = body.damageController
		
		if damageController != null:
			damageController.DamageTarget(bombDamage)
		
		collidedObjects.append(body)
	
	return # Replace with function body.

func DestroyBomb() -> void:
	queue_free()
	
	return
