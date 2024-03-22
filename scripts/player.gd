extends CharacterBody2D

@export var speed : float
var speed_multiplier := 1.0
@export var maximum_health : int = 50
var health := maximum_health
var invincible := false
var fire_rate : float = 1
@onready var animation_player := $PlayerSprite/AnimationPlayer
var xp : int = 0
var level : int = 1

var collected_upgrades = []
var upgrade_options = []
@onready var upgrade_panel = $"../CanvasLayer/UpgradePanel"
@onready var upgrade_option_container = $"../CanvasLayer/UpgradePanel/UpgradeOptions"
var upgrade_option_scene = preload("res://scenes/upgrade_option.tscn")

var apple_scene = preload("res://scenes/apple.tscn")


func _process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * speed_multiplier * 100
	move_and_slide()
	
	if (velocity == Vector2.ZERO):
		animation_player.play("player_idle")
	else:
		animation_player.play("player_walk")
		
	$"../CanvasLayer/Debug/XP Counter".text = "%s XP" % xp
	$"../CanvasLayer/Debug/Level Text".text = "Level %s" % level
	$"../CanvasLayer/XP_Bar".value = xp
	
	if xp >= (25 * pow(2, level)):
		level_up()
			
				
func damage(damage_amount: float) -> void:
	health -= damage_amount
	$"../CanvasLayer/HP_Bar".value = health
	print(health)
	if health <= 0:
		death()
		

func death() -> void:
	pass


func level_up() -> void:
	xp -= (25 * pow(2, level))
	level += 1
	upgrade_panel.visible = true
	var upgrade_options = 0
	var upgrade_options_max = 3
	while upgrade_options < upgrade_options_max:
		var option = upgrade_option_scene.instantiate()
		option.upgrade = get_random_upgrade()
		upgrade_option_container.add_child(option)
		upgrade_options += 1
	Signals.emit_signal("pause_game", true)
#	print(collected_upgrades)
	

func upgrade_player(upgrade: String) -> void:
	match upgrade:
		"player_speed_1":
			speed_multiplier = 1.25
		"player_speed_2":
			speed_multiplier = 1.5
		"fire_rate_1":
			fire_rate = 1.5
		"fire_rate_2":
			fire_rate = 2
		"fire_rate_3":
			fire_rate = 2.5
		"maximum_health_1":
			maximum_health += 50
			health = maximum_health
			$"../CanvasLayer/HP_Bar".max_value = maximum_health
			$"../CanvasLayer/HP_Bar".value = health
	
	var option_children = upgrade_option_container.get_children()
	for option in option_children:
		option.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	upgrade_panel.visible = false
	Signals.emit_signal("pause_game", false)
	$"../CanvasLayer/XP_Bar".max_value = (25 * pow(2, level))
	$"../CanvasLayer/Level_Text".text = "Level %s" % level
	
	
func get_random_upgrade() -> String:
	var upgrade_list = []
	for upgrade in UpgradeManager.UPGRADES:
		# do preliminary checks
		if upgrade in collected_upgrades:
			continue
		if upgrade in upgrade_options:
			continue
		if UpgradeManager.UPGRADES[upgrade]["type"] == "debug":
			pass
			
		# check for prerequisites
		elif UpgradeManager.UPGRADES[upgrade]["prerequisites"].size() > 0:
			for prerequisite in UpgradeManager.UPGRADES[upgrade]["prerequisites"]:
				if prerequisite in collected_upgrades:
					upgrade_list.append(upgrade)
		else:
			upgrade_list.append(upgrade)
#	print(upgrade_list)
	if upgrade_list.size() > 0:
		var random_upgrade = upgrade_list.pick_random()
		upgrade_options.append(random_upgrade)
		return random_upgrade
	else:
		return "debug"
		

func spawn_loot() -> void:
	var radius := 500.0
	var theta := deg_to_rad(randf_range(0.0, 360.0))
#	print(theta)
	var x = position.x + radius * cos(theta)
	var y = position.y + radius * sin(theta)
	
	var loot = apple_scene.instantiate()
	loot.position = Vector2(x, y)
	$"..".add_child(loot)
#	print(loot.position)
	

func _on_area_2d_area_entered(area: Area2D) -> void:
		area.in_player_range = true
		

func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and not invincible:
		damage(area.get_parent().damage)
		invincible = true
		$PlayerHitbox/InvincibilityTimer.start()
	elif area.is_in_group("loot"):
		if health < maximum_health:
			health += 10
			if health > maximum_health:
				health = maximum_health
			$"../CanvasLayer/HP_Bar".value = health
			area.queue_free()


func _on_invincibility_timer_timeout():
	invincible = false


func _on_loot_interval_timeout():
	spawn_loot()
