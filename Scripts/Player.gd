extends CharacterBody2D

@export var sprite : AnimatedSprite2D
@onready var coyote_timer = $CoyoteTimer

const SPEED = 150.0
const IN_AIR_SPEED = 100.0
#const JUMP_VELOCITY = -300.0
const DIVE_VELOCITY = 250.0
const ROLL_VELOCITY = 50.0

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descend : float
@export var coyote_time : float = 0.1
@export var jump_buffer_time : float = 0.1

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descend * jump_time_to_descend)) * -1

var jump_available: bool = true
var jump_buffer: bool = false

@export var camera: Camera2D

var direction
var last_direction

var player_size
var screen_size
var left_bound : float
var right_bound : float
var top_bound : float
var bottom_bound : float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	screen_size = get_camera_size()
	if sprite.sprite_frames:
		var first_frame = sprite.sprite_frames.get_frame_texture("idle", 0) 
		player_size = first_frame.get_size()
	
	# Get camera position and boundaries
	var camera_pos = camera.global_position
	var half_view_size = get_camera_size() / 2
	
	# Calculate screen boundaries relative to camera position
	left_bound = camera_pos.x - half_view_size.x
	right_bound = camera_pos.x + half_view_size.x
	top_bound = camera_pos.y - half_view_size.y
	bottom_bound = camera_pos.y + half_view_size.y

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += find_gravity() * delta
		
	move_and_slide()

	# Horizontal wrapping
	if global_position.x < left_bound - player_size.x/2:
		global_position.x = right_bound + player_size.x/2
	elif global_position.x > right_bound + player_size.x/2:
		global_position.x = left_bound - player_size.x/2

	# Vertical wrapping
	if global_position.y < top_bound - player_size.y/2:
		global_position.y = bottom_bound + player_size.y/2
	elif global_position.y > bottom_bound + player_size.y/2:
		global_position.y = top_bound - player_size.y/2
	
func jump():
	if not jump_available:
		jump_buffer = true
		get_tree().create_timer(jump_buffer_time).timeout.connect(on_jump_buffer_timeout)
		return
	
	velocity.y = jump_velocity
	jump_available = false
	
func find_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func check_if_should_flip(direction):
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

func get_camera_size() -> Vector2:
	# Get the camera's view size based on zoom level
	var view_size = get_viewport_rect().size
	return Vector2(
		view_size.x / camera.zoom.x,
		view_size.y / camera.zoom.y
	)

func coyote_timeout():
	jump_available = false
	
func on_jump_buffer_timeout():
	jump_buffer = false