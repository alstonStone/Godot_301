extends CharacterBody2D


@export var speed := 120.0 # pixels per second

func _ready() -> void:
	var direction := Vector2(randf_range(-1,1),-1).normalized()
	velocity = direction * speed
	
	var inventory : Array[String] = ["key","potion","map","gem"]
	report(inventory)
	loot("swag",inventory)
	report(inventory)
	loot("gem",inventory)
	report(inventory)
	drop("gem",inventory)
	report(inventory)
	drop("gem",inventory)
	report(inventory)
	
func report(bag:Array[String]):
	if bag.is_empty():
		print("The bag is empty")
	else:
		print("# of items: "+str(bag.size()))
		for item:String in bag:
			print(item)

func loot(item:String,bag:Array[String]) -> void:
	if bag.has:
		print("already has item")
	else:
		bag.append(item)

func drop(item:String,bag:Array[String]):
	var item_index:= bag.find(item)
	if  item_index>=0 :
		bag.remove_at(item_index)
	else:
		print("not in the bag")

func spawn_enemies(count:int) -> void:
	var x_val:=0
	var enemies:Array[int]
	for i:int in range(count):
		enemies.append(64*i-1)
	print(enemies)
	pass



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
