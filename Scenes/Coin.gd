extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	HiScore.score += 50
	Sound.play_coin_sound()
	queue_free()
