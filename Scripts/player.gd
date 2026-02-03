extends CharacterBody2D

# Physics variables for player movement (editable in the editor)
@export var speed : int = 300
@export var gravity : int = 600
@export var jump_strength : int = 300

# Additional Variables
var direction = 0
var is_attacking = false

# Access to child nodes of Player
@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D

# Main function where all operations are called
func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	apply_gravity(delta)
	input_handling()
	animation_manager()
	move_and_slide()

# Applying phyics while keeping Main _physics_process clear
func apply_gravity(delta):
	velocity.y += gravity * delta

# Handling edge cases related to player movement
func input_handling():
	direction = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("jump") and is_on_floor() == true:
		velocity.y = -jump_strength
		animationPlayer.play("jump_initial")
		await animationPlayer.animation_finished
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
	if Input.is_action_just_pressed("up"):
		print("up")
	if Input.is_action_just_pressed("down"):
		print("down")

# Handling edge cases related to player animation
func animation_manager():
	# First checking players currently facing direction to determine whether to flip sprite
	if direction > 0:
		animationPlayer.flip_h = false
	elif direction < 0:
		animationPlayer.flip_h = true
	# Determining which animation should be playing
	if is_attacking == false:
		if is_on_floor() and velocity.x != 0:
			animationPlayer.play("run")
		elif is_on_floor() == false:
			animationPlayer.play("jump_fall")
		else:
			animationPlayer.play("idle")
	else:
		animationPlayer.play("attack")
		await animationPlayer.animation_finished
		is_attacking = false
