class_name CameraController
extends Camera2D

static var instance : CameraController

func _init() -> void:
	
	if(instance != null):
		instance.queue_free()
		
	instance = self;
	
	return

func setDestination():
	print('b')
	
	return
