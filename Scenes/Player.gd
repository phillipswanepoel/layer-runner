extends CharacterBody2D


var SPEED : float = 50.0
var JUMP_VELOCITY : float = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_sprite = $AnimatedSprite2D
@onready var collision_shapes = [$fgCollision, $mgCollision, $bgCollision]
@onready var animations = ["fg_run", "mg_run", "bg_run"]
@onready var speeds = [50.0, 40.0, 30.0]
@onready var jumps = [-300.0, -280.0, -260.0]

func _ready() -> void:
	anim_sprite.play("fg_run")	

func change_layer(dir : int):
	# disable collision shapes
	for cs in collision_shapes:
		cs.disabled = true
	# disable collision masks
	for i in range(3):
		set_collision_mask_value(i+1, false)
		
	# enable mask and collision for new layer
	current_layer = (current_layer + dir)%3
	collision_shapes[current_layer].disabled = false	
	set_collision_mask_value(current_layer+1, true)		
	
	#change sprite
	anim_sprite.play(animations[current_layer])
	#change movement
	SPEED = speeds[current_layer]
	JUMP_VELOCITY = jumps[current_layer]

var current_layer : int = 0
func _physics_process(delta):
	#handle layer shifting
	if Input.is_action_just_pressed("ui_up"):
		if current_layer < 2:		
			change_layer(1)			
	elif Input.is_action_just_pressed("ui_down"):	
		if current_layer > 0:	
			change_layer(-1)				
	
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
	
