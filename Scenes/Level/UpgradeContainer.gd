extends HBoxContainer

signal refresh_coin_count
# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	add_buttons()
			
func add_buttons() -> void:
	for u in Upgrades.get_unactivated_upgrades():		
		var button = u.instantiate()
		add_child(button)
		button.upgrade_pressed.connect(_on_upgrade_pressed)	

func _on_upgrade_pressed(upgrade_name : String):	
	#refresh coin count
	refresh_coin_count.emit()
	for child in get_children():		
		if child.get_upgrade_name() == upgrade_name:
			child.queue_free()

func refresh():
	for child in get_children():
		child.queue_free()	
						
	add_buttons()		
