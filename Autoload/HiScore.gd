extends Node

var hi_score = 0
func new_score(s : int) -> void:
	if s > hi_score:
		hi_score = s
