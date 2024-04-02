extends Label

@onready var score = 0

func _on_score_timer_timeout() -> void:
	score += 1
	text = 'Score: ' + str(score)
