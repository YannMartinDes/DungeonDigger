extends Node
class_name Digger

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]


var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var steps_history = []
var steps_since_turn = 0

var steps_nb
var steps_before_turn
var room_min_size
var room_max_size

func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position))
	position = starting_position
	steps_history.append(position)
	borders = new_borders
	
func digs():
	create_room(position)
	for step in steps_nb:
		if steps_since_turn >= steps_before_turn:
			change_direction()
			
		if step():
			steps_history.append(position)
		else:
			change_direction()
	return steps_history
	
func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false
	
func change_direction():
	create_room(position)
	
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	
	while not borders.has_point(position + direction):
		direction = directions.pop_front()
		
		
func create_room(position):
	var size_x = randi() % (room_max_size - room_min_size + 1) + room_min_size
	var size_y = randi() % (room_max_size - room_min_size + 1) + room_min_size
	var size = Vector2(size_x, size_y)
	
	var top_left_corner = (position - size / 2).ceil()

	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x,y)
			if borders.has_point(new_step):
				steps_history.append(new_step)



