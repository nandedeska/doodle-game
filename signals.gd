extends Node

signal pause_game(toggle)

func _ready() -> void:
	connect("pause_game", toggle_pause)
	

func toggle_pause(toggle) -> void:
	get_tree().paused = toggle
	
