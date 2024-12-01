class_name LevelTileMap extends Node

@onready var tile_map_layer: TileMapLayer = $TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.ChangeTilemapBounds( GetTileMapBounds() )
	pass


func GetTileMapBounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	
	bounds.append(
		Vector2(tile_map_layer.get_used_rect().position * tile_map_layer.rendering_quadrant_size)
	)
	
	bounds.append(
		Vector2(tile_map_layer.get_used_rect().end * tile_map_layer.rendering_quadrant_size)
	)
	
	return bounds
