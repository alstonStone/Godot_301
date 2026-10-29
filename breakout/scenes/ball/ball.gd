class_name Ball
extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var speed := 120.0 # pixels per second
@export var paddle : Paddle
@export var min_angle := 0.4

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


func launch(spawn_position: Vector2) -> void:
	position = spawn_position
	current_state = State.Flying
	


func fly(delta:float) -> void:
	var collision := move_and_collide(velocity*delta)
	if collision != null:
		speed+=1
		bounce()
		var collider := collision.get_collider()
		if collider is Paddle:
			#var paddle:Paddle = collider
			velocity = get_velocity_from_paddle(paddle)
			paddle.bounce()
		else:
			if collider is Brick:
				var brick : Brick = collider
				brick.take_damage()
			velocity = velocity.bounce(collision.get_normal()).normalized() *speed
			fix_shallow_angle()
			
		

func dock() -> void:
	position.x = paddle.position.x
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		current_state = State.Flying


func get_velocity_from_paddle(paddel:Paddle) -> Vector2:
	var paddle_half_width := 16
	var offset := (position.x - paddel.position.x) / paddle_half_width
	return Vector2(offset,-1).normalized() * speed

func bounce() -> void:
	audio_stream_player.play()
	create_tween() \
	.tween_property(sprite_2d,"scale",Vector2(1,1),0.1) \
	.from(Vector2(1.5,.5)) \
	.set_trans(Tween.TRANS_BOUNCE) \
	.set_ease(Tween.EASE_IN)

func fix_shallow_angle() -> void:
	var direction := velocity.normalized()
	if direction.y >0 and direction.y < min_angle: 
		direction.y = min_angle 
	elif direction.y <0 and direction.y > -min_angle :
		direction.y = -min_angle 
	velocity = direction * speed
	pass
