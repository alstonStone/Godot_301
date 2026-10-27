extends "res://scenes/bricks/brick.gd"

var BALL = preload("res://scenes/ball/ball.tscn")
var spawn_ammount : int= 3


func take_damage() -> void:
	super()
	for i : int in range(spawn_ammount):
		spawn_ball()

	
	## should i just pass a signal to the world to spawn balls????
func spawn_ball() -> void:
	var new_ball : Ball = BALL.instantiate()
	new_ball.global_position = self.position
	new_ball.current_state = Ball.State.Flying
	print("i ran")
	add_child(new_ball)
	## needs a paddle
	
	
	
	
