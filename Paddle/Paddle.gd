extends Area2D

enum PaddleLocation {
	LEFT,
	RIGHt
}

export (PaddleLocation) var paddle_location = PaddleLocation.LEFT

const SPEED = 100

var input_name = ""

func _ready():
	if paddle_location == PaddleLocation.LEFT:
		input_name = "left_"
	else:
		input_name = "right_"

func _process(delta):

	if Input.is_action_pressed(input_name+"move_up"):
		position.y -= SPEED * delta
	
	if Input.is_action_pressed(input_name+"move_down"):
		position.y += SPEED * delta
	
	position.y = clamp(position.y, 0, 400)


func _on_Paddle_area_entered(area):
	if area is Ball:
		area.direction.x *= -1
		area.direction.y = (area.position.y - position.y) / 16.0
