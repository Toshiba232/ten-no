extends Control

@onready var player = $"../.."

func _on_wroc_pressed() -> void:
	player.pauseMenu()



func _on_wyjdz_pressed() -> void:
	get_tree().quit()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")
