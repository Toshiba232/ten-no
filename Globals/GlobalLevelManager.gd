extends Node

signal level_load_started
signal level_loaded
signal TileMapBoundsChanged( bounds: Array[Vector2])

signal fight_over( fight_path: String, fight: String)

var player_last_position: Vector2
var current_area: String

var current_tilemap_bounds : Array[Vector2]
var target_transition : String
var position_offset : Vector2

var in_menu: bool = true
var in_fight: bool
var current_fight: String

func _ready() -> void:
	await get_tree().process_frame

	current_area = get_tree().current_scene.scene_file_path
	print("Curent area: ", current_area)
	
	level_loaded.emit()
	print("Coś tam emitowało")


func ChangeTilemapBounds(bounds: Array[Vector2]) -> void:
	if bounds == []:
		return
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit(bounds)


func load_new_level(
	level_path: String,
	_target_transition: String,
	_position_offset: Vector2
) -> void:
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
	await SceneTransition.fade_out()
	level_load_started.emit()
	await get_tree().process_frame # Level transition
	
	get_tree().change_scene_to_file(level_path)
	current_area = level_path
	await SceneTransition.fade_in()# Level transition 
	get_tree().paused = false
	
	await get_tree().process_frame 
	level_loaded.emit()

func load_fight(fight_path: String):
	print("Ładowanie walki z LevelManagera")
	print("Pozycja gracza: ", PlayerManager.get_player_position())
	player_last_position = PlayerManager.get_player_position()
	in_fight = true
	current_fight = fight_path
	
	get_tree().paused = true
	await SceneTransition.fade_out()
	level_load_started.emit()
	await get_tree().process_frame # Level transition
	
	get_tree().change_scene_to_file(fight_path)
	await SceneTransition.fade_in()
	get_tree().paused = false
	await get_tree().process_frame
	
	print("Gracz jest? ", PlayerManager.player_spawned)
	
func after_fight(fight: String, victory: GameState.WALKA_STANY):
	get_tree().paused = true
	await SceneTransition.fade_out()
	level_load_started.emit()
	await get_tree().process_frame 
	
	print("Vicroty: ", victory)
	GameState.set_walka(fight, victory)
	
	get_tree().change_scene_to_file(current_area)
	await get_tree().process_frame 
	PlayerManager.set_player_position( player_last_position )
	
	await SceneTransition.fade_in()# Level transition
	in_fight = false
	current_fight = "" 
	get_tree().paused = false
	#PlayerManager.player.can_move = true
	await get_tree().process_frame 
	
	level_loaded.emit()
	print("hehe2")
	fight_over.emit(current_fight, fight)


func quit():
	get_tree().quit()
