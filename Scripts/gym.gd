extends Node2D


func _on_player_on_death() -> void:
	if get_tree() != null:
		get_tree().reload_current_scene()
