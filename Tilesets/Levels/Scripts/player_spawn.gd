extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.in_menu = false
	visible = false
	print("Śprawdzanie cośtam w playerSpawn")
	if PlayerManager.player_spawned == false:
		print("Gracz nie zespawnowany")
		print("Global: ", global_position)
		print("local: ", position)
		if !PlayerManager.is_player_instantiated():
			print("Gracz nie zainstancjonowany. Poprawka.")
			PlayerManager.add_player_instance_but_better()
		PlayerManager.set_player_position( global_position )
		PlayerManager.player_spawned = true
