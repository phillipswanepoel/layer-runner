extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var speed : float = 60.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var buildings = get_tree().get_nodes_in_group("start")	
	for b in buildings:
		b.position.x -= delta * speed

func _on_destruct_timer_timeout() -> void:
	get_tree().call_group('start', 'queue_free')	
	queue_free()
