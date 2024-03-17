extends Sprite2D

const BULLET = preload("res://scenes/bullet.tscn")

@onready var player := $".."
@export var orbit_radius : float

@export_group("Weapon Stats")
@export var bullet_spawn_offset : Vector2
@export var bullet_damage : int
@export var knockback_power : float


func _process(delta: float) -> void:
	var mouse_pos : Vector2 = get_global_mouse_position()
	rotation = atan2((mouse_pos.y - $"..".position.y), (mouse_pos.x - $"..".position.x))
	# look_at(Vector2(mouse_pos.x, mouse_pos.y))
	if orbit_radius > 0:
		position = Vector2(orbit_radius * cos(rotation), orbit_radius * sin(rotation))
	
	if rotation >= PI/2 or rotation <= -PI/2:
		flip_v = true
	else:
		flip_v = false
		
#	for i in range(180):
#		var bullet = BULLET.instantiate()
#		bullet.setup(global_position, global_rotation, 
#				Vector2.RIGHT.rotated(global_rotation + randf_range(global_rotation-deg_to_rad(20), 
#				global_rotation+deg_to_rad(20))), bullet_spawn_offset, 
#				bullet_damage, knockback_power)
#		$"/root".add_child(bullet)


func _on_shoot_interval_timeout() -> void:
	var bullet = BULLET.instantiate()
	bullet.setup(global_position, global_rotation, 
			Vector2.RIGHT.rotated(global_rotation), bullet_spawn_offset, 
			bullet_damage, knockback_power)

	$"/root".add_child(bullet)

