extends ParallaxBackground

# Speed at which the background scrolls
const SCROLL_SPEED = 1
@onready var multi = get_viewport().size.x / get_viewport().size.y
@onready var clouds = $ParallaxLayer

func _process(delta):
	# Calculate the amount to scroll based on the camera's position
	var scroll_amount = SCROLL_SPEED * delta * multi	
	clouds.motion_offset.x -= scroll_amount * clouds.motion_scale.x
