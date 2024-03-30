extends Node

@onready var score = 0
@onready var hi_score = 0
func new_score(s : int) -> void:
	if s > hi_score:
		hi_score = s

func reset_score() -> void:
	score = 0
