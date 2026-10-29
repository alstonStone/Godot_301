class_name Paddle
extends AnimatableBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _physics_process(delta: float) -> void:
	position.x = clamp(get_global_mouse_position().x,17,183)

func bounce() -> void:
	animation_player.play("bounce")
	audio_stream_player.play()
	
