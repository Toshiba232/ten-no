@tool
class_name LevelTransiton extends Area2D


enum SIDE { LEFT, RIGHT, TOP, BOTTOM }
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export_file("*.tscn") var level
@export var target_transition_area : String = "LevelTransiton"


@export_category("Collision Area Settings")

@export_range(1, 12, 1, "or_greater") var size: int = 2 :
	set(_v):
		size = _v
		_update_area()

@export var side: SIDE = SIDE.LEFT :
	set(_v):
		side = _v
		_update_area()
		
@export var snap_to_grid: bool = false :
	set(_v):
		_snap_to_grid()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint():
		return
	
	monitoring = false
	_place_player()
	
	await LevelManager.level_loaded
	
	monitoring = true
	body_entered.connect(_player_entered)

	
func _player_entered(_p: Node2D) -> void:
	LevelManager.load_new_level( level, target_transition_area, get_offset())
	print("Target transition area: ", target_transition_area)
	print()
	pass

func _place_player() -> void:
	if name != LevelManager.target_transition:
		return
	elif LevelManager.in_fight:
		return
	print("Position offset place: ", LevelManager.position_offset)
	print("Target Transition: ", LevelManager.target_transition)
	print()
	PlayerManager.set_player_position( global_position + LevelManager.position_offset )

func get_offset() -> Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos = PlayerManager.player.global_position
	
	if side == SIDE.LEFT or side == SIDE.RIGHT:
		offset.y = player_pos.y - global_position.y
		offset.x = 20 # delikatnie więcej niż 16 by uniknąć transition loop
		if side == SIDE.LEFT:
			offset.x *= -1
	else:	
		offset.x =  player_pos.x - global_position.x
		offset.y = 20 # delikatnie więcej niż 16 by uniknąć transition loop
		if side == SIDE.TOP:
			offset.y *= -1

	return offset
	
func _update_area() -> void:
	var new_rect : Vector2 = Vector2(16,16)
	var new_position : Vector2 = Vector2.ZERO
	
	if 	side == SIDE.TOP:
		new_rect.x *= size
		new_position.y -= 8
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_position.y += 8
	elif side == SIDE.LEFT:
		new_rect.y *= size
		new_position.x -= 8
	elif side == SIDE.RIGHT:
		new_rect.y *= size
		new_position.x += 8
	
	if collision_shape_2d == null:
		collision_shape_2d = get_node("CollisionShape2D")
	
	collision_shape_2d.shape.size = new_rect
	collision_shape_2d.position = new_position	
	
func _snap_to_grid() -> void:
	position.x = round(position.x / 8) * 8
	position.y = round(position.y / 8) * 8