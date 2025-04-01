extends CharacterBody2D


const SPEED = 300.0
var dagger: Node2D
var direction : Vector2
var paused = false
var missingDagger = false
@onready var visBox = $VisibleBox
@onready var main = get_parent()
var throwsLeft = 4
var safe = false
var safeNum = 0
var currentState = "side"
var dagArea : Area2D



func _ready():
	$Sprite.play("sideIdle")
	$Sprite.flip_h = true
	if main.enemyCount == 10:
		throwsLeft = 3
	elif main.enemyCount == 24:
		throwsLeft = 4
	elif main.enemyCount > 25:
		throwsLeft = 5

# Get the gravity from the project settings to be synced with RigidBody nodes.



func _physics_process(delta):
	if !paused:
		if Input.is_action_just_pressed("shoot") and throwsLeft > 0:
			var bods = dagArea.get_overlapping_bodies()
			if not missingDagger and bods.size() < 1:
				dagger.shoot()
				missingDagger = true
				throwsLeft -= 1
				main.throwBox.text = "\n Throws Left: " + str(throwsLeft)
		
		var directionX = Input.get_axis("left", "right")
		if directionX:
			velocity.x = directionX * SPEED
			velocity.y = move_toward(velocity.y, 0, SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if currentState == "side":
				$Sprite.play("sideIdle")
			
		var directionY = Input.get_axis("up", "down")
		if directionY:
			velocity.y = directionY * SPEED
			velocity.x = move_toward(velocity.x, 0, SPEED)
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			if currentState == "front":
				$Sprite.play("frontIdle")
			elif currentState == "back":
				$Sprite.play("backIdle")
			
		
		if velocity.x > 0:
			$Sprite.play("sideWalk")
			$Sprite.flip_h = true
			direction = Vector2.RIGHT
			currentState = "side"
			
			
		elif velocity.x < 0:
			$Sprite.play("sideWalk")
			$Sprite.flip_h = false
			direction = Vector2.LEFT
			currentState = "side"
			
		elif velocity.y < 0:
			$Sprite.play("backWalk")
			$Sprite.flip_h = false
			direction = Vector2.UP
			currentState = "back"
			
		elif velocity.y > 0:
			$Sprite.play("frontWalk")
			$Sprite.flip_h = false
			direction = Vector2.DOWN
			currentState = "front"
			

		move_and_slide()
	
func gameOver():
	$deathTimer.start()
	paused = true




func _on_death_timer_timeout():
	get_tree().change_scene_to_file("res://game_over.tscn")
