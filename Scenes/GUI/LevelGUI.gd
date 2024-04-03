extends Control

func _ready():				
	change_hi_score(HiScore.hi_score)
	
@onready var hi_score_label : Label = $HiScoreLabel
func change_hi_score(new_score : int):
	hi_score_label.text = "Hi Score: " + str(new_score)
	
@onready var restart_button = $DeadGui/RestartButton
func _on_restart_button_pressed() -> void:
	HiScore.reset_score()
	get_tree().reload_current_scene()	

@onready var score_label : Label = $ScoreLabel
func _on_score_timer_timeout() -> void:
	HiScore.score += 1
	score_label.text = 'Score: ' + str(HiScore.score)
	
@onready var coin_label : Label = $CoinLabel
func coin_consumed() -> void:		
	coin_label.text = str(HiScore.coin_count)
	
@onready var dead_gui = $DeadGui
func toggle_dead_gui():	
	$ScoreLabel/ScoreTimer.stop()	
	for button in dead_gui.get_children():
		button.disabled = !button.disabled			
	dead_gui.visible = !dead_gui.visible	
	
@onready var upgrade_gui = $UpgradeGui
@onready var upgrade_back_button = $UpgradeGui/UpgradeBackButton
@onready var upgrade_button_container = $UpgradeGui/UpgradeContainer
func toggle_upgrade_gui():
	upgrade_gui.visible = !upgrade_gui.visible
	upgrade_back_button.disabled = !upgrade_back_button.disabled
	for button in upgrade_button_container.get_children():
		button.disabled = false

@onready var upgrade_button = $DeadGui/UpgradeButton
func _on_upgrade_button_pressed() -> void:
	toggle_dead_gui()
	toggle_upgrade_gui()
	upgrade_button_container.refresh()
	
func _on_upgrade_back_button_pressed() -> void:
	toggle_dead_gui()
	toggle_upgrade_gui()
	
func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_upgrade_container_refresh_coin_count() -> void:
	coin_label.text = str(HiScore.coin_count)
