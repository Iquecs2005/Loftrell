extends Node2D

signal OnDamage

@onready var entityController = get_parent()

var damageAmount : float

func DamageTarget(damage : float):
	damageAmount = damage
	
	OnDamage.emit()
	
	return
