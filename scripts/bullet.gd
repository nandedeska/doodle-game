extends Area2D

var damage : int = 20
var speed : float = 700
var knockback_power : float = 50
var direction : Vector2 = Vector2(1, 0)

func setup(pos, rot, dir, offset, dmg, kb):
	position = pos + offset.rotated(rot)
	rotation = rot
	direction = dir
	damage = dmg
	knockback_power = kb

func _process(delta):
	translate(direction * speed * delta)

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.hit(damage, direction * knockback_power)
	queue_free()

func _on_timer_timeout():
	queue_free()
