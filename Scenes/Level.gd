extends Node2D

# Spawns buildings
# Seperate layers, each has different:
# 1. Movement speed
# 2. Collision layer
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
@onready var player = $FG/Player
func _ready():	
	player.change_player_layer.connect(_on_player_layer_change)
	
@onready var layers = [$FG, $MG, $BG]
func _on_player_layer_change(new_layer: int):		
	player.reparent(layers[new_layer])

var speed : float = 60
var progress : float = 0.0
var fg_speed_factor : float = 0.8
var mg_speed_factor : float = 0.6
var bg_speed_factor : float = 0.3

var cum_delta : float = 0
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
			
	cum_delta += delta
	if cum_delta > 1:
		cum_delta = 0
		speed += 1.5
		
@export var fg_buildings : Array[PackedScene] = []
@onready var fg_timer = $FG/FGTimer
@onready var fg_path = $FG/Path2D
var rand_floor = 0.75
var rand_ceiling = 0.9
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
	var random_wait : float = rng.randf_range(rand_floor, rand_ceiling)*(1/fg_speed_factor)
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
	var random_wait : float = rng.randf_range(rand_floor, rand_ceiling)*(1/mg_speed_factor)
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
	var random_wait : float = rng.randf_range(rand_floor-0.1, rand_ceiling-0.1)*(1/bg_speed_factor)
	bg_timer.start(random_wait)


func _on_building_gaps_timeout() -> void:
	rand_ceiling += 0.1

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_death_zone_body_entered(_body: Node2D) -> void:
	$Control/Button.disabled = false
	$Control/Button.visible = true
	$Control/Label/ScoreTimer.queue_free()
	

@onready var score = 0
@onready var score_label : Label = $Control/Label
func _on_score_timer_timeout() -> void:
	score += 1
	score_label.text = 'Score: ' + str(score)
