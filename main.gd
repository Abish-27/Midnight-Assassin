extends Node2D

var enemyCount = 10
var tile : Vector2i
var atlas = Vector2i(0, 0)
var killedAll = false

@onready var throwBox = %Throws

func completed():
	$Exit.visible = true
	tile = Vector2i(54, 15)
	$TileMap.set_cell(0, tile, 0, atlas)
	tile = Vector2i(54, 16)
	$TileMap.set_cell(0, tile, 0, atlas)
	tile = Vector2i(54, 17)
	$TileMap.set_cell(0, tile, 0, atlas)
	killedAll = true
	


func _on_exit_body_entered(body):
	if killedAll:
		get_tree().change_scene_to_file("res://level_2.tscn")
		
