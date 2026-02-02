extends CharacterBody2D

@export var speed : int = 300
@export var gravity : int = 300
@export var jump_strength : int = 100

var direction = 0

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	apply_gravity(delta)
	input_handling()
	move_and_slide()

func apply_gravity(delta):
	velocity.y += gravity * delta

func input_handling():
	direction = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("jump") and is_on_floor() == true:
		velocity.y = -jump_strength
