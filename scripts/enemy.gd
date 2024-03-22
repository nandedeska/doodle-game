extends RigidBody2D

const EXP_ORB = preload("res://scenes/xp_orb.tscn")

@export var health : int = 50
@export var speed := 50.0
@export var damage : int = 10
var player : CharacterBody2D
@export var xp_value : int = 5
@onready var sprite := $Sprite2D

var is_hit : bool
var direction := Vector2.ZERO
var knockback_direction := Vector2.ZERO


func _ready() -> void:
	position = random_position_outside_player_view()


func _physics_process(delta: float) -> void:
	var frames = Engine.get_process_frames()
	direction = (player.position - position).normalized()
	var distance_to_player = position.distance_to(player.position)
		
	if distance_to_player > 5000:
		position = random_position_outside_player_view()
			
		
#	if position.distance_to(player.position) > 1000:
#		$Collider.disabled = true
	
	var movement := Vector2.ZERO
		
	if distance_to_player > 5:
		if distance_to_player > 3000:
			if frames % 30 == 0:
				movement += direction * speed * delta
		elif distance_to_player > 1500:
			if frames % 15 == 0:
				movement += direction * speed * delta
		else:
			movement += direction * speed * delta

	if is_hit:
#		translate(knockback_direction * delta)
		movement += knockback_direction * delta
		
	move_and_collide(movement)
	
	if frames % 10:
		if position.x < player.position.x:
			sprite.flip_h = false
		else:
			sprite.flip_h = true


func hit(damage: int, knockback: Vector2) -> void:
	if is_hit: return
	health -= damage
	is_hit = true
	knockback_direction = knockback
	$"Knockback Timer".start()
	
	if health <= 0:
		die()
		

func die() -> void:
	var orb = EXP_ORB.instantiate()
	orb.position = position
	orb.player = player
	orb.xp_value = xp_value
	$"/root".call_deferred("add_child", orb)
	queue_free()


func random_position_outside_player_view() -> Vector2:
	var radius := randf_range(1000.0, 2000.0)
	var theta := deg_to_rad(randf_range(0.0, 360.0))
	var x = player.position.x + radius * cos(theta)
	var y = player.position.y + radius * sin(theta)
	
#	match (randi_range(0, 3)):
#		0:
#			#left
#			x = randf_range(player.position.x - get_viewport().size.x - 200, 
#					player.position.x - get_viewport().size.x - 100)
#			y = randf_range(player.position.y - get_viewport().size.y - 200, 
#					player.position.y + get_viewport().size.y + 200)
#		1:
#			#right
#			x = randf_range(player.position.x + get_viewport().size.x + 100, 
#					player.position.x + get_viewport().size.x + 200)
#			y = randf_range(player.position.y - get_viewport().size.y - 200, 
#					player.position.y + get_viewport().size.y + 200)
#		2:
#			#bottom
#			x = randf_range(player.position.x - get_viewport().size.x - 200, 
#					player.position.x + get_viewport().size.x + 200)
#			y = randf_range(player.position.y + get_viewport().size.y + 100, 
#					player.position.y + get_viewport().size.y + 200)
#		3:
#			#top
#			x = randf_range(player.position.x - get_viewport().size.x - 200, 
#					player.position.x + get_viewport().size.x + 200)
#			y = randf_range(player.position.y - get_viewport().size.y - 200, 
#					player.position.y - get_viewport().size.y - 100)
		
	return Vector2(x, y)


func _on_knockback_timer_timeout() -> void:
	is_hit = false
