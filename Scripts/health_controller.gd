class_name HealthController
extends Node2D

signal OnHealthUpdate
signal OnDeath

@onready var entityController = get_parent()

@export var maxHealth : float
@export var isPlayer : bool

var currentHealth : float

var dead : bool

func _ready() -> void:
	currentHealth = maxHealth
	return

func UpdateHealth(amount : float):
	currentHealth += amount
	
	OnHealthUpdate.emit()
	
	if isPlayer:
		UIManager.instance.UpdateHealth(currentHealth)
	
	return

func TakeDamage():
	
	var amount = entityController.damageController.damageAmount
	
	if dead:
		return
	
	UpdateHealth(-amount)
	
	if (currentHealth <= 0):
		dead = true
		OnDeath.emit()
	
	return

func ReceiveHealing(amount : float):
	
	if dead:
		return
	
	UpdateHealth(amount)
	
	if (currentHealth > maxHealth):
		currentHealth = maxHealth
	
	return

func ChangeMaxHealth():
	return
