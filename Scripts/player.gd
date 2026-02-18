extends CharacterBody2D

# Physics variables for player movement (editable in the editor)
@export var speed : int = 300
@export var gravity : int = 600
@export var fall_gravity : int = 900
@export var low_jump_gravity : int = 1200
@export var jump_strength : int = 600

# Additional Variables
var direction = 0
var is_attacking = false
var is_dead = false
var jump_total : float = 10
# Attack vector
var attack_direction = Vector2(1, 0)

# MAGIC NUMBERS SHALL NOT PASS - Enums relate directly to array bellow
enum {RIGHT, LEFT, UP, DOWN}
var attack_directions = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, -1), Vector2(0, 1)]

# Access to child nodes of Player
@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D

# Signals
signal on_death

# Main function where all operations are called
func _physics_process(delta: float) -> void:
	if is_dead == false:
		velocity.x = direction * speed
	else:
		velocity.x = 0
	apply_gravity(delta)
	input_handling()
	animation_manager()
	move_and_slide()

# Applying phyics while keeping Main _physics_process clear
func apply_gravity(delta):
	 # Always apply gravity
	if velocity.y < 0: # going up
		if Input.is_action_pressed("jump"):
			velocity.y += gravity * delta
		else:
			velocity.y += low_jump_gravity * delta
	else: # falling
		velocity.y += fall_gravity * delta

# Determines players velocity and attack direction
func input_handling():
	if is_dead == false:
		direction = Input.get_axis("left", "right")
		if Input.is_action_just_pressed("jump") and is_on_floor() == true:
			velocity.y = -jump_strength
			animationPlayer.play("jump_initial")
		if Input.is_action_just_pressed("attack"):
			is_attacking = true
		if Input.is_action_just_pressed("die(testing)"):
			is_dead = true
		if Input.is_action_just_pressed("up"):
			attack_direction = attack_directions[UP]
		if Input.is_action_just_pressed("down"):
			attack_direction = attack_directions[DOWN]
		if Input.is_action_just_pressed("left"):
			attack_direction = attack_directions[LEFT]
		if Input.is_action_just_pressed("right"):
			attack_direction = attack_directions[RIGHT]


# Determines which animations should play and when
func animation_manager():
	# First checking players currently facing direction to determine whether to flip sprite
	if direction > 0:
		animationPlayer.flip_h = false
	elif direction < 0:
		animationPlayer.flip_h = true
	# Determining which animation should be playing
	if is_dead == false:
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
	elif is_dead == true:
		if animationPlayer.animation != "death":
			animationPlayer.play("death")
			await animationPlayer.animation_finished
			death()

func death():
	is_dead = true
	on_death.emit()
