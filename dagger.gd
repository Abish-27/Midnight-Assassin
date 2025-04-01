extends Node2D


@onready var player = get_parent().get_parent()
@onready var marker = get_parent()
@onready var main = player.get_parent()
var flying = false
const SPEED = 1000
var direction = Vector2.RIGHT
const RANGE = 400
var distance : float



func _ready():
	player.dagger = self
	player.dagArea = %Area2D




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not player.missingDagger:
		if player.velocity.x > 0:
			#rotation = 50
			marker.rotation = deg_to_rad(-360)
			position.x = 86
			position.y = -3
			
		elif player.velocity.x < 0:
			#rotation = 50
			marker.rotation = deg_to_rad(-180)
			position.x = 60
			position.y = -3
			
		if player.velocity.y > 0:
			#rotation = 50
			marker.rotation = deg_to_rad(-270)
			position.y = -10
			position.x = 86
			
		if player.velocity.y < 0:
			#rotation = 50
			marker.rotation = deg_to_rad(-87)
			position.x = 66
			position.y = -3
			
		
		
		
	if flying:
		
		global_position += delta * direction * SPEED
		distance += delta * SPEED
		if distance > RANGE:
			flying = false
		rotation += 0.4
			
	

	

func shoot():
	$knifeSound.play()
	var pos = global_position
	top_level = true
	global_position = pos
	distance = 0.0
	direction = player.direction
	flying = true
	
	


func _on_area_2d_body_entered(body):
	if body.has_method("die"):
		$knifeSound.play()
		%DaggerSprite.play("default")
		$killTime.start()
		if body.has_method("Kingy"):
			main.enemyCount = 0
		body.die()
		
		main.enemyCount -= 1
		if main.enemyCount < 1:
			main.completed()
			
	elif player.missingDagger:
		flying = false
		
		if body.has_method("gameOver"):
			player.missingDagger = false

			top_level = false
			global_position = player.global_position		
			position = Vector2(83, -10)
			rotation = deg_to_rad(50)
		


func _on_kill_time_timeout():
	%DaggerSprite.stop()
