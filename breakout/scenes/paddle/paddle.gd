extends AnimatableBody2D

var player_name:= "Robin"
var score:=0
var speed:=4.6

func add_points(amount:int) -> int:
	score += amount
	return score

func reset() -> void:
	score = 0


func _physics_process(delta: float) -> void:
	position.x = clamp(get_global_mouse_position().x,17,183)
