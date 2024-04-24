extends HBoxContainer

signal upgrade_cd_pressed(upgrade_name)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	add_buttons()
	if Upgrades.upgrade_count > 0 && Upgrades.upgrade_count < 3:
		$HelpText.visible = true
		$Timer.start()
	
func add_shortcut(number : int, button) -> void:
	var shortcut = Shortcut.new()
	var key = InputEventKey.new()
	
	if number == 1:				
		key.keycode = KEY_1
	elif number == 2:
		key.keycode = KEY_2
	elif number == 3:
		key.keycode = KEY_3
	elif number == 4:
		key.keycode = KEY_4
	elif number == 5:
		key.keycode = KEY_5
	
	shortcut.events.append(key)
	button.shortcut = shortcut
			
func add_buttons() -> void:
	var count = 1
	for u in Upgrades.get_activated_upgrades_hotkeys():		
		var button = u.instantiate()
		add_child(button)
		button.hotkey_pressed.connect(_on_upgrade_pressed)	
		add_shortcut(count, button)
		count+=1

func _on_upgrade_pressed(upgrade_name : String):	
	upgrade_cd_pressed.emit(upgrade_name)

func refresh():
	for child in get_children():
		child.queue_free()	
						
	add_buttons()

func _on_timer_timeout() -> void:
	$HelpText.visible = false
