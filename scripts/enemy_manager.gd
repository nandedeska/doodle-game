extends Node

const  ENEMY = preload("res://scenes/enemy.tscn")

@onready var time_start := Time.get_ticks_msec()
@export var player : CharacterBody2D
var spawn_amount : int = 8
var enemy_count : int


func _ready() -> void:
	for i in range(8):
		spawn()


func _process(delta: float) -> void:
	var elapsed_time : int = (Time.get_ticks_msec() - time_start) / 1000
	enemy_count = len(get_tree().get_nodes_in_group("enemy"))
	
	$"../Debug Texts/Time Elapsed Text".text = "%ss" % elapsed_time
	$"../Debug Texts/Enemy Counter Text".text = "%s" % enemy_count


func spawn() -> void:
	var enemy = ENEMY.instantiate()
	$"/root".add_child.call_deferred(enemy)
	enemy.player = player


func _on_spawn_timer_timeout() -> void:
	for i in range(spawn_amount):
		if enemy_count > 1000:
			break
		spawn()
	$SpawnTimer.wait_time = randf_range(4, 12)
	$SpawnTimer.start()


func _on_difficulty_timer_timeout() -> void:
	spawn_amount += 2

