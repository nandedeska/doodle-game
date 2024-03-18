extends CharacterBody2D

@export var speed : float
@onready var animation_player := $PlayerSprite/AnimationPlayer
var xp := 0
var level := 1


func _process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * 100
	move_and_slide()
	
	if (velocity == Vector2.ZERO):
		animation_player.play("player_idle")
	else:
		animation_player.play("player_walk")
		
	$"../Debug Texts/XP Counter".text = "%s XP" % xp
	$"../Debug Texts/Level Text".text = "Level %s" % level
			
	if xp >= (25 * pow(2, level)):
		level_up()
				

func level_up() -> void:
	xp -= (25 * pow(2, level))
	level += 1
	$"../Upgrade Menu".visible = true
	Signals.emit_signal("pause_game", true)
	
	
func _on_upgrade_button_button_up() -> void:
	Signals.emit_signal("pause_game", false)
	$"../Upgrade Menu".visible = false
	

func _on_area_2d_area_entered(area):
	area.in_player_range = true

