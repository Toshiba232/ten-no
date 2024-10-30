extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

const Balloon = preload("res://dialogue/balloon.tscn")

signal DialogStarted

func _ready() -> void:

	DialogueManager.dialogue_ended.connect(end)

func action() -> void:
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
	#DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	DialogStarted.emit()

func end():
	print("GEGEGWEGWE")
	pass
	
