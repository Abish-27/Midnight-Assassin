extends Node2D


var enemyCount = 100
var killedAll = false


@onready var throwBox = %Throws

func completed():
	$winTimer.start()
	




func _on_win_timer_timeout():
	get_tree().change_scene_to_file("res://victory.tscn")
