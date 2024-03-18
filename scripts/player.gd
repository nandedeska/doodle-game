extends CharacterBody2D

@export var speed : float
@onready var animation_player := $PlayerSprite/AnimationPlayer
var xp := 0


func _process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * 100
	move_and_slide()
	
	if (velocity == Vector2.ZERO):
		animation_player.play("player_idle")
	else:
		animation_player.play("player_walk")
		
	$"../CanvasLayer/XP Counter".text = "%s XP" % xp


func _on_area_2d_area_entered(area):
	area.in_player_range = true
