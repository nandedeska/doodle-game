extends CharacterBody2D

@export var speed : float
@onready var animation_player := $PlayerSprite/AnimationPlayer
var xp := 0
var level := 1

var collected_upgrades = []
var upgrade_options = []
@onready var upgrade_panel = $"../CanvasLayer/UpgradePanel"
@onready var upgrade_option_container = $"../CanvasLayer/UpgradePanel/UpgradeOptions"
var upgrade_option_scene = preload("res://scenes/upgrade_option.tscn")

func _process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * 100
	move_and_slide()
	
	if (velocity == Vector2.ZERO):
		animation_player.play("player_idle")
	else:
		animation_player.play("player_walk")
		
	$"../CanvasLayer/Debug/XP Counter".text = "%s XP" % xp
	$"../CanvasLayer/Debug/Level Text".text = "Level %s" % level
			
	if xp >= (25 * pow(2, level)):
		level_up()
				

func level_up() -> void:
	xp -= (25 * pow(2, level))
	level += 1
	upgrade_panel.visible = true
	var upgrade_options = 0
	var upgrade_options_max = 3
	while upgrade_options < upgrade_options_max:
		var option = upgrade_option_scene.instantiate()
		option.upgrade = get_random_upgrade()
		
		if option.upgrade == null:
			option.upgrade = "debug"
			
		upgrade_option_container.add_child(option)
		upgrade_options += 1
	Signals.emit_signal("pause_game", true)
	print(collected_upgrades)
	

func upgrade_player(upgrade) -> void:
	var option_children = upgrade_option_container.get_children()
	for option in option_children:
		option.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	upgrade_panel.visible = false
	Signals.emit_signal("pause_game", false)
	
	
func get_random_upgrade():
	var upgrade_list = []
	for upgrade in UpgradeManager.UPGRADES:
		# do preliminary checks
		if upgrade in collected_upgrades:
			pass
		elif upgrade in upgrade_options:
			pass
#		if UpgradeManager.UPGRADES[upgrade]["type"] != "character":
#			pass
			
		# check for prerequisites
		elif UpgradeManager.UPGRADES[upgrade]["prerequisites"].size() > 0:
			for prerequisite in UpgradeManager.UPGRADES[upgrade]["prerequisites"]:
				if prerequisite in collected_upgrades:
					upgrade_list.append(upgrade)
		else:
			upgrade_list.append(upgrade)
	print(upgrade_list)
	if upgrade_list.size() > 0:
		var random_upgrade = upgrade_list.pick_random()
		upgrade_options.append(random_upgrade)
		return random_upgrade
	else:
		return null
	

func _on_area_2d_area_entered(area):
	area.in_player_range = true

