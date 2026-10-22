extends CharacterBody2D


@export var speed := 120.0 # pixels per second

func _ready() -> void:
	var direction := Vector2(randf_range(-1,1),-1).normalized()
	velocity = direction * speed
	
	var wave_1:Array[String] = ["thing","bat","ghost","boss","test"]
	var wave_2:Array[String] = ["boss","thing","bat","ghost","test"]
	spawn_wave(wave_2)

func spawn_enemies(count:int) -> void:
	var x_val:=0
	var enemies:Array[int]
	for i:int in range(count):
		enemies.append(64*i)
	print(enemies)
	pass

func spawn_wave(wave:Array[String]) -> void:
	var enemy_count:=0
	for enemy:String in wave:
		enemy_count+=1
		if enemy == "ghost":
			continue
		elif enemy == "boss":
			print("BOSS - wave over")
			break
		else:
			print("spawn %s" %enemy)
	print("spawned: %d" % enemy_count)


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity*delta)
	if collision != null:
		var ball_position = collision.get_position()
		var collider := collision.get_collider()
		if collider is Paddle:
			var paddle:Paddle = collider
			velocity = get_velocity_from_paddle(paddle)
		else:
			if collider is Brick:
				var brick : Brick = collider
				brick.take_damage()
			velocity = velocity.bounce(collision.get_normal())
	

func get_velocity_from_paddle(paddel:Paddle) -> Vector2:
	var paddle_half_width := 16
	var offset := (position.x - paddel.position.x) / paddle_half_width
	return Vector2(offset,-1).normalized() * speed
