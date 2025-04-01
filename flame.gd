extends Node2D


func _ready():
	$Fire.play("default")


func _on_area_2d_area_entered(area):
	$sound.play()
	$Light.visible = false
	$Fire.queue_free()
	$Area2D.queue_free()
	$LightRadius.queue_free()
