extends CharacterBody2D

@export var speed : float
@onready var animation_player = $PlayerSprite/AnimationPlayer

func _process(delta):
	# distance from player to cursor
	# var distance_to_cursor : float = sqrt(pow((mouse_pos.y - position.y), 2) + pow((mouse_pos.x - position.x), 2))
	# print(distance_to_cursor / 100)
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * 100
	move_and_slide()
	
	if (velocity == Vector2.ZERO):
		animation_player.play("player_idle")
	else:
		animation_player.play("player_walk")
