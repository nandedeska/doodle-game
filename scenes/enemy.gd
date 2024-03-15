extends Area2D

@export var maximum_health : int = 50
var health : int = maximum_health
@export var speed : float = 50
var player : CharacterBody2D
var xp_value : int = 5

var is_hit : bool
var knockback_direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	var direction = (player.position - position).normalized()
	
	if position.distance_to(player.position) > 5:
		translate(direction * speed * delta)

	if is_hit:
		translate(knockback_direction * delta)

# handles incoming damage
func hit(damage, knockback):
	if is_hit: return
	health -= damage
	is_hit = true
	knockback_direction = knockback
	$"Knockback Timer".start()
	
	if health <= 0:
		queue_free()


func _on_knockback_timer_timeout():
	is_hit = false
