extends PathFollow2D

@onready var buildings = $StartBuilding
# Called when the node enters the scene tree for the first time.
var speed : float = 60
var fg_speed_factor : float = 0.8
var mg_speed_factor : float = 0.6
var bg_speed_factor : float = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var distance = speed * delta
	
	progress += distance 
	if progress_ratio > 0.95:
		queue_free()
