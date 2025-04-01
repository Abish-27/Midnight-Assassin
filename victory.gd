extends Node2D

func _ready():
	$Sprite.play("default")
	$sound.play()

func _on_how_button_pressed():
	get_tree().change_scene_to_file("res://home.tscn")
