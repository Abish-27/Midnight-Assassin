extends CharacterBody2D

var lights = []

func _ready():
	$Sprite.play("default")


func die():
	queue_free()
	
func Kingy():
	print("I am Kingy")


func _on_sight_body_entered(body):
	if body.has_method("gameOver"):
		lights = body.visBox.get_overlapping_areas()
		if lights.size() > 0 and body.safeNum < 1:
			$sound.play()
			$Surprise.visible = true
			body.gameOver()
			$Sprite.play("idle")
