extends Button

signal upgrade_pressed(upgrade_name)
var upgrade_name : String = "DoubleJump"
var cost : int = 2

func _on_pressed() -> void:	
	if cost <= HiScore.coin_count:
		HiScore.coin_count -= cost
		Upgrades.upgrade_pressed(upgrade_name)	
		upgrade_pressed.emit(get_upgrade_name())
					
func get_upgrade_name() -> String:
	return upgrade_name
