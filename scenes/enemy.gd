extends RigidBody2D

@export var maximum_health : int = 50
var health := maximum_health
@export var speed := 50.0
var player : CharacterBody2D
var xp_value : int = 5

var is_hit : bool
var direction := Vector2.ZERO
var knockback_direction := Vector2.ZERO


func _ready() -> void:
	position = random_position_outside_player_view()


func _physics_process(delta: float) -> void:
	if Engine.get_process_frames() % 30 == 0:
		direction = (player.position - position).normalized()
		
	if position.distance_to(player.position) > 3000:
		position = random_position_outside_player_view()
		
#	if position.distance_to(player.position) > 1000:
#		$Collider.disabled = true
	
	var movement := Vector2.ZERO
		
	if position.distance_to(player.position) > 5:
#		translate(direction * speed * delta)
		movement += direction * speed * delta

	if is_hit:
#		translate(knockback_direction * delta)
		movement += knockback_direction * delta
		
	move_and_collide(movement)


func hit(damage: int, knockback: Vector2) -> void:
	if is_hit: return
	health -= damage
	is_hit = true
	knockback_direction = knockback
	$"Knockback Timer".start()
	
	if health <= 0:
		queue_free()


func random_position_outside_player_view() -> Vector2:
	var x
	var y
	
	match (randi_range(0, 3)):
		0:
			#left
			x = randf_range(player.position.x - get_viewport().size.x - 200, 
					player.position.x - get_viewport().size.x - 100)
			y = randf_range(player.position.y - get_viewport().size.y - 200, 
					player.position.y + get_viewport().size.y + 200)
		1:
			#right
			x = randf_range(player.position.x + get_viewport().size.x + 100, 
					player.position.x + get_viewport().size.x + 200)
			y = randf_range(player.position.y - get_viewport().size.y - 200, 
					player.position.y + get_viewport().size.y + 200)
		2:
			#bottom
			x = randf_range(player.position.x - get_viewport().size.x - 200, 
					player.position.x + get_viewport().size.x + 200)
			y = randf_range(player.position.y + get_viewport().size.y + 100, 
					player.position.y + get_viewport().size.y + 200)
		3:
			#top
			x = randf_range(player.position.x - get_viewport().size.x - 200, 
					player.position.x + get_viewport().size.x + 200)
			y = randf_range(player.position.y - get_viewport().size.y - 200, 
					player.position.y - get_viewport().size.y - 100)
		
	return Vector2(x, y)


func _on_knockback_timer_timeout() -> void:
	is_hit = false

