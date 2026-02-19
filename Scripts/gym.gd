extends Node2D

@onready var fireball_prefab = preload("res://Objects/fireball.tscn")

func _on_player_on_death() -> void:
	if get_tree() != null:
		get_tree().call_deferred("reload_current_scene")


func _on_player_cast(pos: Vector2, dir: Vector2) -> void:
	var fireball = fireball_prefab.instantiate()
	fireball.setup(pos, dir)
	add_child(fireball)
