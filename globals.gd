extends Node


signal dialogue_finished()

func _ready() -> void:
	dialogue_finished.connect(_on_dialogue_end)

func _on_dialogue_end():
	print("Zakończono dialog")
	var playas = get_tree().get_nodes_in_group("player")
	if playas.size() > 0:
		playas[0].can_move = true
