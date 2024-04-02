extends Button

signal upgrade_pressed(upgrade_name)

func _on_pressed() -> void:
	print("button knows it has been pressed")
	upgrade_pressed.emit(get_upgrade_name())
	
func get_upgrade_name() -> String:
	return "DoubleJump"
