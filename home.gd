extends Node2D

func _ready():
	$Torch1.play("default")
	$Torch2.play("default")


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_how_button_pressed():
	get_tree().change_scene_to_file("res://tutorial.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")
