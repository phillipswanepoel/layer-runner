extends Node2D

var all_upgrades : Array[PackedScene] = []
@export var all_upgrade_names : Array[String] = []
@export var all_upgrade_has_hotkey : Array[bool] = []
var activated_upgrade_names : Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for upgrade_name in all_upgrade_names:
		all_upgrades.append(load("res://Scenes/Upgrades/" + upgrade_name + ".tscn"))
	
func upgrade_pressed(upgrade_name : String):
	activated_upgrade_names.append(upgrade_name)
	
func get_unactivated_upgrade_names():
	var unactivated_upgrade_names = HelperFunctions.subtract(all_upgrade_names, activated_upgrade_names)
	return unactivated_upgrade_names
		
func get_unactivated_upgrades() -> Array[PackedScene]:
	var out : Array[PackedScene] = []
	for upgrade_name in get_unactivated_upgrade_names():
		out.append(load("res://Scenes/Upgrades/" + upgrade_name + ".tscn"))
	return out
	
func get_unactivated_upgrades_hotkeys() -> Array[PackedScene]:
	var out : Array[PackedScene] = []
	var count = 0
	for upgrade_name in all_upgrade_names:
		if all_upgrade_has_hotkey[count] and upgrade_name in get_unactivated_upgrade_names():
			out.append(load("res://Scenes/Upgrades/Hotkeys/" + upgrade_name + "CD.tscn"))
		count+=1		
	return out
	
func get_activated_upgrades_hotkeys() -> Array[PackedScene]:
	var out : Array[PackedScene] = []
	var count = 0
	for upgrade_name in all_upgrade_names:
		if all_upgrade_has_hotkey[count] and upgrade_name in get_activated_upgrade_names():
			out.append(load("res://Scenes/Upgrades/Hotkeys/" + upgrade_name + "CD.tscn"))
		count+=1		
	return out
	
	
func get_activated_upgrade_names() -> Array[String]:
	return activated_upgrade_names
	
func get_activated_upgrades()  -> Array[PackedScene]:
	var out : Array[PackedScene] = []
	for upgrade_name in get_activated_upgrade_names():
		out.append(load("res://Scenes/Upgrades/" + upgrade_name + ".tscn"))
	return out
