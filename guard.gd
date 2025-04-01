extends CharacterBody2D

var state : int
const SPEED = 70
var RANGE : int
var walking = false
var paused = false

var distance = 0
var lights = []


func _ready():
	state = randi_range(0, 1)
	RANGE = randi_range(100, 250)
	$Sprite.play("walk")
	walking = true
	$IdleTime.wait_time = randf_range(3.5, 6)
	if state == 1:
		$Sprite.flip_h = true
		$Sight.position.x = -450
	else:
		$Sight.position.x = 14
		

	
func _physics_process(delta):
	if walking and !paused:
		if state == 0:
			velocity.x = SPEED 
		elif state == 1:
			velocity.x = SPEED * -1
		
		distance += SPEED * delta
		
		if distance > RANGE:
			walking = false
			$IdleTime.start()
			$Sprite.play("idle")
		
		move_and_slide()

func die():
	queue_free()


func _on_idle_time_timeout():
	walking = true
	$Sprite.play("walk")
	distance = 0
	if state == 0:
		state = 1
		$Sprite.flip_h = true
		$Sight.position.x = -450
	elif state == 1:
		state = 0
		$Sprite.flip_h = false
		$Sight.position.x = 14
		


func _on_sight_body_entered(body):
	if body.has_method("gameOver"):
		lights = body.visBox.get_overlapping_areas()
		if lights.size() > 0 and body.safeNum < 1:
			$sound.play()
			$Surprise.visible = true
			body.gameOver()
			$Sprite.play("idle")
			paused = true
	
