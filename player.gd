extends CharacterBody2D

var acceleration = 50
var max_speed = 500
var damp_direction = 0
const GRAVITY = 9.8

func accelerate(direction: int) -> void:
	velocity.x += acceleration*direction
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	damp_direction = direction
	print(velocity)
	
func damp() -> void:
	if damp_direction == 1:
		velocity.x = max(velocity.x-acceleration, 0)
	if damp_direction == -1:
		velocity.x = min(velocity.x+acceleration, 0)
	print(velocity)

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
		velocity.y = -400
	
	if direction != 0:
		$AnimatedSprite2D.play("walk")
		accelerate(direction)
	else:
		$AnimatedSprite2D.stop()
		damp()
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
	velocity.y += GRAVITY
	move_and_slide()
