extends Node2D

# Spawns buildings
# Seperate layers, each has different:
# 1. Movement speed
# 2. Collision layer
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var speed : float = 60
var progress : float = 0.0
var fg_speed_factor : float = 1.0
var mg_speed_factor : float = 0.6
var bg_speed_factor : float = 0.3

func _physics_process(delta):
	var distance = speed * delta
	var path_followers = get_tree().get_nodes_in_group("path_followers")
	
	for pf in path_followers:
		var mod_distance : float = 1.0
		if pf.is_in_group("fg_followers"):
			mod_distance = (distance * fg_speed_factor)
		elif pf.is_in_group("mg_followers"):
			mod_distance = (distance * mg_speed_factor)
		elif pf.is_in_group("bg_followers"):
			mod_distance = (distance * bg_speed_factor)
			
		pf.progress += mod_distance
		if pf.progress_ratio > 0.95:
			pf.queue_free()
		
@export var fg_buildings : Array[PackedScene] = []
@onready var fg_timer = $FG/FGTimer
@onready var fg_path = $FG/Path2D
func _on_fg_timer_timeout() -> void:		
	#spawn a random fg building, attach to its movement path
	var chosen_building = fg_buildings.pick_random().instantiate()	
	var path_follow = PathFollow2D.new()
	path_follow.rotates = false
	path_follow.add_to_group("path_followers")
	path_follow.add_to_group("fg_followers")
	fg_path.add_child(path_follow)
	path_follow.add_child(chosen_building)
	
	#start timer with some random interval
	var random_wait : float = rng.randf_range(0.5, 1.8)*(1/fg_speed_factor)
	fg_timer.start(random_wait)
	
@export var mg_buildings : Array[PackedScene] = []
@onready var mg_timer = $MG/MGTimer
@onready var mg_path = $MG/Path2D
func _on_mg_timer_timeout() -> void:	
	#spawn a random fg building, attach to its movement path
	var chosen_building : StaticBody2D = mg_buildings.pick_random().instantiate()	
	chosen_building.set_collision_layer_value(1, false)
	chosen_building.set_collision_layer_value(2, true)
	
	var path_follow = PathFollow2D.new()
	path_follow.rotates = false
	path_follow.loop = false
	
	path_follow.add_to_group("path_followers")
	path_follow.add_to_group("mg_followers")
	mg_path.add_child(path_follow)
	path_follow.add_child(chosen_building)
	
	#start timer with some random interval
	var random_wait : float = rng.randf_range(0.5, 2.0)*(1/mg_speed_factor)
	mg_timer.start(random_wait)
	
@export var bg_buildings : Array[PackedScene] = []
@onready var bg_timer = $BG/BGTimer
@onready var bg_path = $BG/Path2D
func _on_bg_timer_timeout() -> void:	
	#spawn a random fg building, attach to its movement path
	var chosen_building : StaticBody2D = bg_buildings.pick_random().instantiate()	
	chosen_building.set_collision_layer_value(1, false)
	chosen_building.set_collision_layer_value(3, true)
	var path_follow = PathFollow2D.new()
	path_follow.rotates = false
	path_follow.add_to_group("path_followers")
	path_follow.add_to_group("bg_followers")
	bg_path.add_child(path_follow)
	path_follow.add_child(chosen_building)
	
	#start timer with some random interval
	var random_wait : float = rng.randf_range(0.5, 2.0)*(1/bg_speed_factor)
	bg_timer.start(random_wait)

