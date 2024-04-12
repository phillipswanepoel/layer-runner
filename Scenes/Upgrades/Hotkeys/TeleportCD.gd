extends Button

signal hotkey_pressed(upgrade_name)

@onready var time_label = $MarginContainer/Label
@export var cooldown : float
@onready var timer = $Sweep/Timer
@onready var sweep = $Sweep
@onready var upgrade_name = "Teleport"

func _ready():
	timer.wait_time = cooldown
	time_label.hide()	
	sweep.value = 0
	set_process(false)

func _process(_delta):
	time_label.text = str(round(timer.time_left))
	sweep.value = int((timer.time_left / cooldown) * 100)

func _on_timer_timeout() -> void:
	print("ability ready")
	sweep.value = 0
	disabled = false
	time_label.hide()
	set_process(false)

func _on_pressed() -> void:
	disabled = true
	set_process(true)
	timer.start()
	time_label.show()
	hotkey_pressed.emit(upgrade_name)
	
func get_upgrade_name() -> String:
	return upgrade_name
	

