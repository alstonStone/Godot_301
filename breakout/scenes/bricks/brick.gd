class_name Brick
extends StaticBody2D

signal destroyed(brick : Brick)


@onready var brick_sprite: Sprite2D = $BrickSprite
@onready var health := brick_sprite.vframes
@onready var explosion_area: Area2D = $ExplosionArea

@export var balls_spawned := 0
@export var value := 10
var is_dying = false





func take_damage() -> void:
	if not is_dying:
		health -= 1
		if health <= 0:
			is_dying = true
			queue_free()
			explode_neighbors()
			destroyed.emit(self)
		else:
			brick_sprite.frame += 1

func explode_neighbors() -> void:
	var neighbors : Array[Node2D] = explosion_area.get_overlapping_bodies()
	for neighbor : Node2D in neighbors:
		if neighbor is Brick and neighbor != self:
			var brick:Brick = neighbor
			brick.take_damage()
