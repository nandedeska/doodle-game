extends ColorRect


@onready var name_text = $DisplayName
@onready var description_text = $Description
@onready var display_icon = $ColorRect/UpgradeIcon

var upgrade = null

func _ready() -> void:
	name_text.text = UpgradeManager.UPGRADES[upgrade]["display_name"]
	description_text.text = UpgradeManager.UPGRADES[upgrade]["description"]
	display_icon.texture = load(UpgradeManager.UPGRADES[upgrade]["icon"])


func _on_upgrade_button_button_down() -> void:
	Signals.emit_signal("select_upgrade", upgrade)
