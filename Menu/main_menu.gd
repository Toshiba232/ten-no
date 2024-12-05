class_name  Menu extends Control

func _on_play_pressed() -> void:
	print("Wciskanieee")
	var level_path = "res://Tilesets/Levels/Area1/level_house.tscn"
	var transition = ""  # Możesz dostosować przejście
	var position_offset = Vector2.ZERO  # Brak przesunięcia pozycji

	# Wywołujemy funkcję load_new_level z wszystkimi trzema argumentami
	LevelManager.load_new_level(level_path, transition, position_offset)
	print("Poziom został załadowany.")
	
# Funkcja wywoływana po kliknięciu Quit
func _on_quit_pressed() -> void:
	print("Wciskaniee2e")
	get_tree().quit()
