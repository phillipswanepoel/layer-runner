extends Node2D


@onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("day-night")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
