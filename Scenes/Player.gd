extends CharacterBody2D


const SPEED : float = 100.0
const JUMP_VELOCITY : float = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func shrink():
	if current_layer != 2.0:
		$AnimatedSprite2D.scale *= 0.5	
		$CollisionShape2D.shape.size *= 0.5	
	else:
		$AnimatedSprite2D.scale = Vector2(0.25, 0.25)
		$CollisionShape2D.shape.size = Vector2(32, 32)

var current_layer : int = 0
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		velocity.y = JUMP_VELOCITY
		shrink()
		set_collision_mask_value(current_layer+1, false)	
		current_layer = (current_layer + 1)%3		
		set_collision_mask_value(current_layer+1, true)		
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
