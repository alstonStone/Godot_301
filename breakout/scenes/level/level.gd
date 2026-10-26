class_name Level
extends Node2D


var brick_blueprint := preload("res://scenes/bricks/brick.tscn")
var hard_brick_blueprint := preload("res://scenes/bricks/hard_brick.tscn")
var level : Array[String] = [
	"OOOOHOO O",
	"OO OOOOOO",
	"OOOOHOOOO",
	"OOOOOHHOO",
	"HHOOOOOOO",
	"OOOOO OOO",
	"OOO OOOOO",
	"OOHHOO OO"
]

func _ready() -> void:
	var x_gap := 20
	var y_gap := 10
	var nb_rows := 8
	var nb_cols := 9
	var top_left:= Vector2(20,20)
	
	for row:int in range(nb_rows):
		for col:int in range(nb_cols):
			var brick:Brick = null
			if level[row][col] =="O":
				brick = brick_blueprint.instantiate()
			elif level[row][col] =="H":
				brick = hard_brick_blueprint.instantiate()
				
			if brick !=null:
				brick.position = Vector2(top_left.x + (col*x_gap), top_left.y + (row*y_gap))
				add_child(brick)
