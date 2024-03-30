extends Node2D

@onready var button_sound = $Button
func play_button_sound():
	button_sound.play()
	
@onready var warp_sound = $Warp
func play_warp_sound():
	warp_sound.play()
	
@onready var warp_sound2 = $Warp2
func play_warp_sound2():
	warp_sound2.play()
	
@onready var death_sound = $DeathSound
func play_death_sound():
	death_sound.play()
	
@onready var bus_music = AudioServer.get_bus_index("Music")
@onready var sound_busses = [AudioServer.get_bus_index("Reverb"),
							AudioServer.get_bus_index("Low"),
							AudioServer.get_bus_index("Death")]
func _ready() -> void:
	update_music_volume(50.0)		
	update_sound_volume(50.0)		

func update_music_volume(new : float):	
	AudioServer.set_bus_volume_db(bus_music, linear_to_db(new/10.0))
	
func update_sound_volume(new : float):
	for bus in sound_busses:
		AudioServer.set_bus_volume_db(bus, linear_to_db(new/10.0))
		
