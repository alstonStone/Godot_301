class_name World
extends Node2D


var ball_blueprint = preload("res://scenes/ball/ball.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var paddle: Paddle = $Paddle
@onready var level: Level = $Level
@onready var score_label: Label = $ScoreLabel


var balls_left := 0
var score := 0

func _ready() -> void:
	level.level_complete.connect(level_completed)
	create_new_ball()


func _on_ball_detection_area_body_entered(body: Node2D) -> void:
	body.queue_free()
	balls_left -=1
	if balls_left <= 0:
		animation_player.play("ball_dropped")
		score-=500
		score_label.text = "%06d"%score

func create_new_ball() -> void:
	var new_ball : Ball = ball_blueprint.instantiate()
	new_ball.global_position = Vector2(0,paddle.position.y-8)
	new_ball.paddle = paddle
	add_child(new_ball)
	balls_left+=1


func level_completed() -> void:
	level.current_level_index+=1
	if level.has_next_level():
		level.current_level_index-=1
		destroy_all_balls()
		animation_player.play("Win")
	else:
		animation_player.play("GameOver")
		destroy_all_balls()

func load_next_level() -> void:
	level.load_next_level()
	create_new_ball()

func destroy_all_balls() -> void:
	for child: Node in get_children():
		if child is Ball:
			child.queue_free()
	balls_left = 0
	

func _on_level_spawn_requested(amount: int, spawn_position: Vector2) -> void:
	for i: int in amount:
		spawn_ball(spawn_position)
		balls_left+=1
		



func spawn_ball(position: Vector2):
	var new_ball : Ball = ball_blueprint.instantiate()
	new_ball.global_position = Vector2(0,paddle.position.y-8)
	new_ball.paddle = paddle
	add_child(new_ball)
	new_ball.launch(position)
	


func _on_level_brick_removed(brick: Brick) -> void:
	score+=brick.value * balls_left
	score_label.text = "%06d"%score
