extends CharacterBody2D

var acceleration = 30
var air_acceleration = 10
var max_speed = 600
var damping = 40
var air_damping = 15
var damp_direction = 0
const GRAVITY = 15

func move(direction: int) -> void:
	if direction != 0:
		accelerate(direction)
	else: 
		damp()
	
	velocity.y += GRAVITY
	move_and_slide()

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

func move2(direction: int) -> void:
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
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("right"):
		direction += 1
	if Input.is_action_pressed("left"):
		direction -= 1
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -600
	move2(direction)
	if direction != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.stop()
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
	
