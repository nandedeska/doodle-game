extends Node

signal pause_game(toggle)
signal select_upgrade(upgrade)

@onready var player = get_tree().get_first_node_in_group("player")


func _ready() -> void:
	connect("pause_game", toggle_pause)
	connect("select_upgrade", Callable(player, "upgrade_player"))
	

func toggle_pause(toggle) -> void:
	get_tree().paused = toggle
	
