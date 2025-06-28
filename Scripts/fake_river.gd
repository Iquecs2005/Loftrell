class_name FakeRiver
extends StaticBody2D

func OnTreeFall():
	collision_layer = 0
	$LogSprite.visible = true

func Reset():
	collision_layer = 2
	$LogSprite.visible = false
