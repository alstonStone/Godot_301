class_name World
extends Node2D


var ball_blueprint = preload("res://scenes/ball/ball.tscn")


func _on_ball_detection_area_body_entered(body: Node2D) -> void:
	body.queue_free()
	$AnimationPlayer.play("ball_dropped")

func create_new_ball() -> void:
	var new_ball : Ball = ball_blueprint.instantiate()
	new_ball.global_position = Vector2(0,$Paddle.position.y-8)
	new_ball.paddle = $Paddle
	add_child(new_ball)
