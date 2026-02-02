extends CharacterBody2D
var direction

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction * 500
	move_and_slide()
	print(direction)
