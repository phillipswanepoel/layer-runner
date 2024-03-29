extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var hi_score = 0
func new_score(s : int) -> void:
	if s > hi_score:
		hi_score = s
