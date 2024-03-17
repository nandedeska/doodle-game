extends Area2D

var damage : int = 20
var speed := 700.0
var knockback_power := 50.0
var direction := Vector2(1, 0)

var traveled_distance := 0.0
var max_distance := 2000.0

func setup(pos, rot, dir, offset, dmg, kb) -> void:
	position = pos + offset.rotated(rot)
	rotation = rot
	direction = dir
	damage = dmg
	knockback_power = kb

func _process(delta: float) -> void:
	translate(direction * speed * delta)
	traveled_distance += speed * delta
	if traveled_distance > max_distance:
		queue_free()


func _on_area_entered(area) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().hit(damage, direction * knockback_power)
	
	queue_free()
	
