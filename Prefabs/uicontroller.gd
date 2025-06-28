class_name UIManager
extends Control

static var instance : UIManager

@export var HeartTypes : Array[Texture]
@export var HeartTextures : Array[TextureRect]

func _init() -> void:
	
	if(instance != null):
		instance.queue_free()
		
	instance = self;
	
	return

func UpdateHealth(health : int):
	for texture in HeartTextures:
		if health >= 2:
			texture.texture = HeartTypes[0]
			health -= 2
		elif health == 1:
			texture.texture = HeartTypes[1]
			health -= 1
		else:
			texture.texture = HeartTypes[2]
	return
