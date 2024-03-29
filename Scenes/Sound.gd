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
	
