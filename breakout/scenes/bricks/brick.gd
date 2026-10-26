class_name Brick
extends StaticBody2D

@onready var brick_sprite: Sprite2D = $BrickSprite
var health = brick_sprite.vframes

func take_damage() -> void:
	health -= 1
	if health < 0:
		queue_free()
	else:
		brick_sprite.frame += 1
