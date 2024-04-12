extends CharacterBody2D


var SPEED : float = 65.0
var JUMP_VELOCITY : float = -350.0
var JUMP_VELOCITY_SMALL : float = -150.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_sprite = $AnimatedSprite2D
@onready var collision_shapes = [$fgCollision, $mgCollision, $bgCollision]
@onready var animations = ["fg_run", "mg_run", "bg_run"]
@onready var animation_jumps = ["fg_jump", "mg_jump", "bg_jump"]
@onready var speeds = [65.0, 55.0, 45.0]
@onready var jumps = [-350.0, -320.0, -290.0]
@onready var jumps_small = [-150.0, -130.0, -110.0]

@onready var double_jump_upgraded : bool = false
@onready var back_run_upgraded : bool = false
@onready var teleport_upgraded : bool = false
var upgrades = []
func _ready() -> void:
	anim_sprite.play("fg_run")	
	upgrades = Upgrades.get_activated_upgrade_names()	
	if "DoubleJump" in upgrades:
		double_jump_upgraded = true
	if "BackRun" in upgrades:
		back_run_upgraded = true
	if "Teleport" in upgrades:
		teleport_upgraded = true		

signal change_player_layer(new_layer)
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
	
	
	for i in range(5, 8):
		set_collision_layer_value(i, false)
	if current_layer == 0:
		set_collision_layer_value(5, true)	
	elif current_layer == 1:
		set_collision_layer_value(6, true)	
	else:
		set_collision_layer_value(7, true)	
	
	#change sprite and visual layer
	anim_sprite.play(animations[current_layer])
	change_player_layer.emit(current_layer)
	#change movement
	SPEED = speeds[current_layer]
	JUMP_VELOCITY = jumps[current_layer]
	JUMP_VELOCITY_SMALL = jumps_small[current_layer]
	
func _jump_cut():
	pass	
	
func teleport():
	var dir = 0
	if velocity.x >= 0:
		dir = 1
	elif velocity.x < 0:
		dir = -1		
	position.x += 70*dir
	

var current_layer : int = 0
var double_jump_used : bool = false
var jump_timer : float = 0.0
func _physics_process(delta):
	#handle layer shifting		
	var will_collide = false
	if Input.is_action_just_pressed("ui_up"):				
		if current_layer < 2:	
			Sound.play_warp_sound()	
			change_layer(1)		
			will_collide = test_move(transform, Vector2.ZERO)		
			
	elif Input.is_action_just_pressed("ui_down"):			
		if current_layer > 0:	
			Sound.play_warp_sound2()	
			change_layer(-1)		
			will_collide = test_move(transform, Vector2.ZERO)					
			
	#if will_collide is true: this is a problem, character must now fall
	if will_collide:
		for i in range(3):
			set_collision_mask_value(i+1, false)
	
	# Add the gravity.
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += gravity * delta * 1.3
		else:			
			velocity.y += gravity * delta
		anim_sprite.play(animation_jumps[current_layer])
	else:
		anim_sprite.play(animations[current_layer])
		double_jump_used = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("jump") and double_jump_upgraded and not double_jump_used:
		velocity.y = JUMP_VELOCITY
		double_jump_used = true
	if Input.is_action_just_released("jump"):
		if velocity.y < JUMP_VELOCITY_SMALL:
			velocity.y = JUMP_VELOCITY_SMALL
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var is_running : bool = false
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:		
		if back_run_upgraded and velocity.x < 0:
			velocity.x = direction * SPEED * 1.6
		else:			
			velocity.x = direction * SPEED
		is_running = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#run = sprite faster
	if is_running:
		anim_sprite.speed_scale = 1.5
	else:
		anim_sprite.speed_scale = 1

	move_and_slide()
	
