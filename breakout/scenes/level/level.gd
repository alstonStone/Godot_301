class_name Level
extends Node2D


var brick_blueprint := preload("res://scenes/bricks/brick.tscn")
var level : Array[String] = [
	"101010101",
	"000000000",
	"000000000",
	"000000000",
	"000000000",
	"000000000",
	"000000000",
	"000000000",
	"000000000"
]

func _ready() -> void:
	var x_gap := 20
	var y_gap := 10
	var nb_rows := 8
	var nb_cols := 9
	var top_left:= Vector2(20,20)
	
	for row:int in range(nb_rows):
		for col:int in range(nb_cols):
			if level[row][col] =="0":
				var brick :Brick = brick_blueprint.instantiate()
				brick.position = Vector2(top_left.x + (col*x_gap), top_left.y + (row*y_gap))
				add_child(brick)
