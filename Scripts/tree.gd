class_name TreeObject
extends StaticBody2D

@onready var healthController = $HealthController
@onready var damageController = $DamageController

signal OnTreeChop

func ChopDownTree():
	OnTreeChop.emit()
	$Sprite2D.visible = false
	collision_layer = 0
	return

func Reset():
	$Sprite2D.visible = true
	collision_layer = 3
	$HealthController.dead = false
	$HealthController.ReceiveHealing(999)
