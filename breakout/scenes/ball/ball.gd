extends CharacterBody2D


@export var speed := 2.0 # pixels per second

func _ready() -> void:
	var direction := Vector2(randf_range(-1,1),-1).normalized()
	velocity = direction * speed


func _physics_process(delta: float) -> void:
	move_and_collide(velocity*delta)
