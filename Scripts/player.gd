extends CharacterBody2D

@export var SPEED : int
var direction

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction * SPEED
	animationManager()
	move_and_slide()
	

func animationManager():
	if direction == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	elif direction.x > 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
