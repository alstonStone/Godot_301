class_name Level
extends Node2D

signal level_complete
signal spawn_requested(amount: int, spawn_position: Vector2)
signal brick_removed(brick:Brick)

var brick_blueprint := preload("res://scenes/bricks/brick.tscn")
var hard_brick_blueprint := preload("res://scenes/bricks/hard_brick.tscn")
var bomb_brick_blueprint := preload("res://scenes/bricks/bomb_brick.tscn")
var spawner_brick_blueprint := preload("res://scenes/bricks/spawner_brick.tscn")

var nb_bricks := 0

var level : Array[String] = [
	#"         ",
	#"         ",
	#"         ",
	#"         ",
	#"         ",
	#"         ",
	#"    O     ",
	#"         "
#]

	"OOOOHOO O",
	"OO OOOOB0",
	"OOOOHOOSO",
	"OBOOSHHOO",
	"HHOOOOOBO",
	"OOOBO OOO",
	"OOB OOOOO",
	"OSHHBB OO"
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
			elif level[row][col] =="B":
				brick = bomb_brick_blueprint.instantiate()
			elif level[row][col] =="S":
				brick = spawner_brick_blueprint.instantiate()
			if brick !=null:
				brick.position = Vector2(top_left.x + (col*x_gap), top_left.y + (row*y_gap))
				add_child(brick)
				brick.destroyed.connect(brick_destroyed)
				nb_bricks +=1


func brick_destroyed(brick : Brick) -> void:
	nb_bricks -=1
	brick_removed.emit(brick)
	if brick.balls_spawned > 0:
		spawn_requested.emit(brick.balls_spawned,brick.position )
	if nb_bricks <= 0:
		level_complete.emit()
