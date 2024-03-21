extends Node


const ICON_PATH = "res://sprites/upgrade icons/"
const UPGRADES = {
	"player_speed_1": {
		"icon": ICON_PATH + "character_speed.png",
		"display_name": "Player Speed I",
		"description": "Movement speed is increased to 1.25x the base speed.",
		"prerequisites": [],
		"type": "character",
	},
	"player_speed_2": {
		"icon": ICON_PATH + "character_speed.png",
		"display_name": "Player Speed II",
		"description": "Movement speed is increased to 1.5x the base speed.",
		"prerequisites": ["player_speed_1"],
		"type": "character",
	},
	"fire_rate_1": {
		"icon": ICON_PATH + "fire_rate.png",
		"display_name": "Faster Fire Rate I",
		"description": "Fire rate is increased to 1.5x the base speed.",
		"prerequisites": [],
		"type": "weapon",
	},
	"fire_rate_2": {
		"icon": ICON_PATH + "fire_rate.png",
		"display_name": "Faster Fire Rate II",
		"description": "Fire rate is increased to 2x the base speed.",
		"prerequisites": ["fire_rate_1"],
		"type": "weapon",
	},
	"maximum_health_1": {
		"icon": ICON_PATH + "hp_max.png",
		"display_name": "Increase Max HP",
		"description": "Maximum healthpoints is increased by 50.",
		"prerequisites": [],
		"type": "character",
	},
	"debug": {
		"icon": "res://sprites/icon.svg",
		"display_name": "Debug",
		"description": "Null.",
		"prerequisites": [],
		"type": "debug",
	},
}

