extends Node2D

@onready var global_player_manager = $"res://Globals/GlobalPlayerManager.gd"

func _on_play_pressed() -> void:
	if global_player_manager and global_player_manager.player:
		global_player_manager.player.queue_free()  # Używamy queue_free, aby bezpiecznie usunąć gracza
		print("Gracz został usunięty.")
	get_tree().change_scene_to_file("res://Tilesets/Levels/Area1/level_house.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
