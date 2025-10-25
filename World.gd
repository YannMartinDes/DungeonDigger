extends Node2D

var borders = Rect2(1,1,37,19)
var steps_nb = 400  # This is exposed to the UI
var steps_before_turn = 8  # This is exposed to the UI
var chance_to_turn = 5  # This is exposed to the UI
var room_min_size = 2
var room_max_size = 5  # this will be controlled by the slider

onready var tileMap = $Dungeon

func _ready():
	randomize()
	generate_level()
	
func resetDungeon():
	for x in range(borders.position.x, borders.end.x):
		for y in range(borders.position.y, borders.end.y):
			tileMap.set_cell(x, y, 0) 

func generate_level():
	resetDungeon()  # í ¾í·¹ clear all previously set tiles
	
	var digger = Digger.new(Vector2(19,10), borders)
	digger.room_min_size = room_min_size
	digger.room_max_size = room_max_size
	digger.steps_before_turn = steps_before_turn
	digger.chance_to_turn = chance_to_turn
	digger.steps_nb = steps_nb
	
	var map = digger.digs()
	digger.queue_free()
	
	for location in map:
		tileMap.set_cellv(location, -1)
	
	tileMap.update_bitmask_region(borders.position, borders.end)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		generate_level()
