extends TileMap

@export var TILE_SCENES: Dictionary = {
	Vector2(1,0): preload("res://Characters/player.tscn")
}
@onready var half_cell_size := tile_set.tile_size * 0.5

var search_layer := 2

func _ready():
	await get_tree().process_frame
	#print(get_cell_source_id(2, Vector2(1,0)))
	#_replace_tiles_with_scene()

func _replace_tiles_with_scene(scene_dictionary: Dictionary = TILE_SCENES):
	for key in scene_dictionary.keys():
		for tile_pos in get_used_cells_by_id(search_layer, 0, key):
				var object_scene = scene_dictionary[key]
				_replace_tile_with_object(tile_pos, object_scene)

func _replace_tile_with_object(tile_pos: Vector2, object_scene: PackedScene, parent: Node = get_tree().current_scene):
	# Clear the cell in TileMap
	if get_cell_source_id(search_layer,tile_pos) != -1:
		set_cell(search_layer, tile_pos, -1)
	
	#Spawn the object	
	if object_scene:
		var obj = object_scene.instantiate() as StaticBody2D
		var ob_pos = map_to_local(tile_pos) - half_cell_size 
		
		parent.add_child(obj)
		obj.global_position = to_global(ob_pos)
