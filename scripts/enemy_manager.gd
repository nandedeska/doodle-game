extends Node

@onready var time_start : int = Time.get_ticks_msec()
@export var player : CharacterBody2D
var enemy_scene = preload("res://scenes/enemy.tscn")
var spawn_amount : int = 4

func _ready():
	for i in range(8):
		spawn()

func _process(delta):
	var elapsed_time : int = (Time.get_ticks_msec() - time_start) / 1000
	$"../CanvasLayer/Time Elapsed Text".text = "%ss" % elapsed_time
	$"../CanvasLayer/Enemy Counter Text".text = "%s" % len(get_tree().get_nodes_in_group("enemy"))

func spawn():
	var enemy = enemy_scene.instantiate()
	$"/root".add_child.call_deferred(enemy)
	enemy.position = random_position_outside_player_view()
	enemy.player = player
	
func random_position_outside_player_view():
	var x
	var y
	
	match (randi_range(0, 3)):
		0:
			#left
			x = randf_range(player.position.x - get_viewport().size.x - 200, player.position.x - get_viewport().size.x - 100)
			y = randf_range(player.position.y - get_viewport().size.y - 200, player.position.y + get_viewport().size.y + 200)
		1:
			#right
			x = randf_range(player.position.x + get_viewport().size.x + 100, player.position.x + get_viewport().size.x + 200)
			y = randf_range(player.position.y - get_viewport().size.y - 200, player.position.y + get_viewport().size.y + 200)
		2:
			#bottom
			x = randf_range(player.position.x - get_viewport().size.x - 200, player.position.x + get_viewport().size.x + 200)
			y = randf_range(player.position.y + get_viewport().size.y + 100, player.position.y + get_viewport().size.y + 200)
		3:
			#top
			x = randf_range(player.position.x - get_viewport().size.x - 200, player.position.x + get_viewport().size.x + 200)
			y = randf_range(player.position.y - get_viewport().size.y - 200, player.position.y - get_viewport().size.y - 100)
		
	return Vector2(x, y)

func _on_spawn_timer_timeout():
	for i in range(spawn_amount):
		spawn()
	$SpawnTimer.wait_time = randf_range(4, 12)
	$SpawnTimer.start()


func _on_difficulty_timer_timeout():
	spawn_amount += 2
