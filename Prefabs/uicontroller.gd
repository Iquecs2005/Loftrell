class_name UIManager
extends Control

static var instance : UIManager

@export var HeartTextures : Array[TextureRect]

func _init() -> void:
	
	if(instance != null):
		instance.queue_free()
		
	instance = self;
	
	return

func UpdateHealth(health : int):
	print("a")
	
	for texture in HeartTextures:
		if health >= 2:
			texture.region = Rect2(0,0,17,17)
			health -= 2
		elif health == 1:
			texture.region = Rect2(17,17,17,17)
			health -= 1
		else:
			texture.region = Rect2(34,34,17,17)
	return
