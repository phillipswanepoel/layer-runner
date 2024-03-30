extends Node2D


@onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("day-night")
	$CanvasLayer/Boy.play("default")

func _on_play_button_pressed() -> void:
	Sound.play_button_sound()
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")

@onready var buttons_main = $CanvasLayer3/Control1
@onready var buttons_settings = $CanvasLayer3/Settings
func _on_settings_button_pressed() -> void:
	Sound.play_button_sound()
	buttons_main.visible = false
	buttons_settings.visible = true	
	
func _on_quit_button_pressed() -> void:
	Sound.play_button_sound()
	get_tree().quit()

func _on_music_volume_slider_value_changed(value: float) -> void:
	Sound.update_music_volume(value)

func _on_sound_volume_slider_value_changed(value: float) -> void:
	Sound.update_sound_volume(value)
	Sound.play_button_sound()

func _on_button_pressed() -> void:
	buttons_main.visible = true
	buttons_settings.visible = false
