extends Node2D

@onready var time_start : int = Time.get_ticks_msec()
@export var amplitude : float
@export var frequency : float


func _process(delta):
	var elapsed_time : int = Time.get_ticks_msec() - time_start
	position.y = sin(elapsed_time * frequency / 500) * amplitude
