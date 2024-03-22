extends Node2D

@onready var time_start := Time.get_ticks_msec()
@export var amplitude : float
@export var frequency : float
var initial_y_position : float


func _ready() -> void:
	initial_y_position = position.y
	

func _process(delta: float) -> void:
	var elapsed_time : int = Time.get_ticks_msec() - time_start
	position.y = initial_y_position + sin(elapsed_time * frequency / 500) * amplitude

