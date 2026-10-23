class_name Ball
extends CharacterBody2D


@export var speed := 120.0 # pixels per second
@export var paddle : Paddle

enum State {Docked,Flying}
var current_state:= State.Docked


func _ready() -> void:
	var direction := Vector2(randf_range(-1,1),-1).normalized()
	velocity = direction * speed


func _physics_process(delta: float) -> void:
	if current_state == State.Docked:
		dock()
	else:
		fly(delta)
	
	

func fly(delta:float) -> void:
	var collision := move_and_collide(velocity*delta)
	if collision != null:
		speed+=1
		var collider := collision.get_collider()
		if collider is Paddle:
			#var paddle:Paddle = collider
			velocity = get_velocity_from_paddle(paddle)
		else:
			if collider is Brick:
				var brick : Brick = collider
				brick.take_damage()
			velocity = velocity.bounce(collision.get_normal()).normalized() *speed

func dock() -> void:
	position.x = paddle.position.x
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		current_state = State.Flying


func get_velocity_from_paddle(paddel:Paddle) -> Vector2:
	var paddle_half_width := 16
	var offset := (position.x - paddel.position.x) / paddle_half_width
	return Vector2(offset,-1).normalized() * speed
