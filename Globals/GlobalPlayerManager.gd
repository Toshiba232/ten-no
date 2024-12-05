extends Node

const PLAYER = preload("res://Player/player.tscn")

var player: Player
var player_spawned: bool = false


var last_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if LevelManager.in_fight:
		print("Aktualnie trwa walka")
		return	
	elif LevelManager.in_menu:
		print("Jestem w menu")
		return
		
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true
	pass # Replace with function body.


func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	
func add_player_instance_but_better() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true
		
func is_player_instantiated() -> bool:
	return player != null
	

func get_player_position() -> Vector2:
	last_position = player.global_position
	return last_position
	
	
func move_player_cutscene(_move: Vector2) -> void:
	player.move_cutscene(_move)

func set_player_position( _new_pos: Vector2) -> void:
	player.global_position = _new_pos
	player.direction = Vector2.ZERO
	player.velocity = Vector2.ZERO
	last_position = player.global_position
	#player.UpdateAnimation("idle")

func set_as_parent( _p: Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)

func unparent_player( _p: Node2D) -> void:
	_p.remove_child( player )


		
