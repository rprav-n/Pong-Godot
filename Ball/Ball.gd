extends Area2D

class_name Ball

var speed = 200
var direction = Vector2.LEFT

func _process(delta):
	speed += delta * 2
	position += speed * direction * delta
