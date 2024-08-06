class_name Warp
extends Area2D

@export var map_scene: PackedScene



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_packed(map_scene)
		
