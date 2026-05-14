extends CharacterBody2D

var acceleration = 30
var air_acceleration = 10
var max_speed = 600
var damping = 40
var air_damping = 15
var damp_direction = 0
const GRAVITY = 15

func accelerate(direction: int) -> void:
	velocity.x += acceleration*direction
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	damp_direction = direction
	print(velocity)
	
	
func damp() -> void:
	var curr_direction = sign(velocity.x)
	if curr_direction == 1:
		velocity.x = max(velocity.x-acceleration, 0)
	if curr_direction == -1:
		velocity.x = min(velocity.x+acceleration, 0)
	print(velocity)

func move(direction: int) -> void:
	#accelerate and clamp max speed
	velocity.x += (acceleration if is_on_floor() else air_acceleration )*direction
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	#if switching direction or letting go, apply damping
	var curr_direction = sign(velocity.x)
	if curr_direction != direction:
		velocity.x -= min(damping if is_on_floor() else air_damping, abs(velocity.x))*curr_direction
	velocity.y += GRAVITY
	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WeaponSprite2D.texture = load("res://assets/weapon_club.png")
	$AnimatedSprite2D.flip_h = true
	$WeaponSprite2D.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = randi_range(-1, 1)
	move(direction)
	
	
	
	if direction != 0:
		$AnimatedSprite2D.play("evil_walk")
	else:
		$AnimatedSprite2D.stop()
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
		$WeaponSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
		$WeaponSprite2D.flip_h = true
	
