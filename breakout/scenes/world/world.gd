class_name World
extends Node2D


var ball_blueprint = preload("res://scenes/ball/ball.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var paddle: Paddle = $Paddle
@onready var level: Level = $Level

func _ready() -> void:
	level.level_complete.connect(level_completed)


func _on_ball_detection_area_body_entered(body: Node2D) -> void:
	body.queue_free()
	animation_player.play("ball_dropped")

func create_new_ball() -> void:
	var new_ball : Ball = ball_blueprint.instantiate()
	new_ball.global_position = Vector2(0,paddle.position.y-8)
	new_ball.paddle = paddle
	add_child(new_ball)


func level_completed() -> void:
	animation_player.play("Win")

	
	
