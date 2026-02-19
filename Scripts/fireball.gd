extends Area2D
@export var fireball_speed : int = 1000
@export var damage = -1
var direction : Vector2 = Vector2.RIGHT
@onready var animationManager : AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	translate(direction * fireball_speed * delta)
	if direction.x > 0:
		animationManager.flip_h = false
	if direction.x < 0:
		animationManager.flip_h = true
	else:
		animationManager.flip_h = false
	if direction.y > 0:
		rotation = deg_to_rad(90)
	if direction.y < 0:
		rotation = deg_to_rad(-90)

	if $VisibleOnScreenNotifier2D.is_on_screen() == false:
		queue_free()

func setup(pos: Vector2, dir: Vector2):
	direction = dir
	position = pos


func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.has_method("hit"):
		body.hit(-1)
		print("hello")
