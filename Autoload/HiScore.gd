extends Node

@onready var score = 0
@onready var hi_score = 0
@onready var coin_count = 0
@onready var upgrade_list = ["DoubleJump"]
func new_score(s : int) -> void:
	if s > hi_score:
		hi_score = s
		
func add_coin():
	coin_count+=1
	
func remove_coins(r : int):	
	coin_count -= r

func reset_score() -> void:
	score = 0
