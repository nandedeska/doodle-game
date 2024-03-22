extends Area2D

var player : CharacterBody2D
var in_player_range := false
var xp_value := 0

func _physics_process(delta: float) -> void:
	if in_player_range:
		position = position.lerp(player.position, 0.08)
		
		if Engine.get_process_frames() % 4 == 0:
			if position.distance_squared_to(player.position) < 2500:
				player.xp += xp_value
				queue_free()
