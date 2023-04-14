extends Node2D

onready var ball_container = $BallContainer
onready var ball_spawn_location = $BallContainer/BallSpawnLocation

onready var reset_timer = $ResetTimer

onready var score_label = $Graphics/Label

onready var paddle_spawn_position = $PaddleContainer/PaddleSpawnPosition
onready var left_paddle = $PaddleContainer/LeftPaddle
onready var right_paddle = $PaddleContainer/RightPaddle

var score = Vector2.ZERO
const WINNING_SCORE = 2

var Ball = preload("res://Ball/Ball.tscn")
var ball

func _ready():
	create_ball()
	
func _on_ball_out(wall_name):
	update_score(wall_name)
#	reset_timer.start()
	
func create_ball():
	ball = Ball.instance()
	ball.position = ball_spawn_location.position
	ball_container.call_deferred("add_child", ball)


func _on_ResetTimer_timeout():
	create_ball()

func update_score(wall_name):
	match wall_name:
		"LeftWall":
			score.y += 1
		"RightWall":
			score.x += 1
	update_score_label()
	if score.x >= WINNING_SCORE || score.y >= WINNING_SCORE:
		game_over()
	else:
		reset_timer.start()
		reset_paddle_position()
		

func update_score_label():
	score_label.text = "%d | %d" % [score.x, score.y]

func game_over():
	reset_paddle_position()
	score = Vector2.ZERO
	update_score_label()
	reset_timer.start()

func reset_paddle_position():
	left_paddle.position = paddle_spawn_position.position
	left_paddle.position.x = 30
	right_paddle.position = paddle_spawn_position.position
	right_paddle.position.x = 610
