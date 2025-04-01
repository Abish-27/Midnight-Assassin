extends Area2D


func _on_body_entered(body):
	body.safeNum += 1
	



func _on_body_exited(body):
	body.safeNum -= 1
