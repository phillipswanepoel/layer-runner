extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(_body: Node2D) -> void:
	HiScore.score += 50	
	Sound.play_coin_sound(layer)
	queue_free()

@onready var layer = 0
@onready var colliders = [	$CollisionShape2D,
							$CollisionShape2D2,
							$CollisionShape2D3	]
					
func set_layer(l : int):
	var sprite = $AnimatedSprite2D
	layer = l
	if layer == 2:
		sprite.scale = Vector2(0.1, 0.1)
		colliders[0].disabled = true
		colliders[1].disabled = true
		colliders[2].disabled = false
		set_collision_mask_value(5, false) 
		set_collision_mask_value(7, true) 		
	elif layer == 1:
		sprite.scale = Vector2(0.25, 0.25)
		colliders[0].disabled = true
		colliders[1].disabled = false
		colliders[2].disabled = true
		set_collision_mask_value(5, false) 
		set_collision_mask_value(6, true) 
		
