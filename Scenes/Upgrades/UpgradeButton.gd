extends Button

class_name UpgradeButton

signal upgrade_pressed(upgrade_name)
var upgrade_name : String
var has_hotkey : bool
@export var cost : int = 1

func _ready() -> void:
	$Label.text = str(cost)

func _on_pressed() -> void:	
	if cost <= HiScore.coin_count:
		HiScore.coin_count -= cost
		Upgrades.upgrade_pressed(upgrade_name)	
		upgrade_pressed.emit(get_upgrade_name())
					
func get_upgrade_name() -> String:
	return upgrade_name

func get_has_hotkey() -> bool:
	return has_hotkey
