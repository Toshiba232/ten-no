extends Control

var global_player_manager : Node
var global_level_manager : Node

# Funkcja wywoływana po kliknięciu Play
func _ready() -> void:
	# Ręczne ładowanie GlobalPlayerManager
	global_player_manager = preload("res://Globals/GlobalPlayerManager.gd").new()
	
	# Sprawdzamy, czy global_player_manager jest poprawnie załadowany
	if global_player_manager != null:
		print("GlobalPlayerManager został załadowany poprawnie!")
	else:
		print("Błąd: GlobalPlayerManager nie został poprawnie załadowany.")

	# Jeśli GlobalLevelManager nie jest w scenie, instancjonujemy go
	global_level_manager = preload("res://Globals/GlobalLevelManager.gd").new()
	
	# Sprawdzamy, czy global_level_manager jest poprawnie załadowany
	if global_level_manager != null:
		print("GlobalLevelManager został załadowany poprawnie!")
	else:
		print("Błąd: GlobalLevelManager nie został poprawnie załadowany.")
		

# Funkcja wywoływana po kliknięciu Play
func _on_play_pressed() -> void:
	if global_player_manager and global_level_manager:
		# Przygotowujemy gracza do załadowania
		global_player_manager.request_ready()

		# Zmieniamy scenę na poziom gry z wymaganymi argumentami
		var level_path = "res://Tilesets/Levels/Area1/level_house.tscn"
		var transition = "fade_out"  # Możesz dostosować przejście
		var position_offset = Vector2.ZERO  # Brak przesunięcia pozycji

		# Wywołujemy funkcję load_new_level z wszystkimi trzema argumentami
		global_level_manager.load_new_level(level_path, transition, position_offset)
		print("Poziom został załadowany.")
	else:
		print("Błąd: global_player_manager lub global_level_manager nie zostały poprawnie załadowane.")
	
# Funkcja wywoływana po kliknięciu Quit
func _on_quit_pressed() -> void:
	get_tree().quit()
