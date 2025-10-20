extends CanvasLayer


func _ready():
	
	$StepLabel.text = "Steps: 400"
	$TurnLabel.text = "Steps before turn: 8"
	$RoomLabel.text = "Room size: 2 - 5"
	
	$Steps.connect("value_changed", self, "_on_slider_steps_value_changed")
	$Turn.connect("value_changed", self, "_on_slider_turn_value_changed")
	$MinRoom.connect("value_changed", self, "_on_min_slider_changed")
	$MaxRoom.connect("value_changed", self, "_on_max_slider_changed")
	
	$Button.connect("pressed", get_node("../"), "generate_level")

	
func _on_slider_steps_value_changed(value):	
	var world = get_node("../")  # parent is World
	world.steps_nb = int(value)	
	$StepLabel.text = "Steps: " + str(value)
	
func _on_slider_turn_value_changed(value):	
	var world = get_node("../")  # parent is World
	world.steps_before_turn = int(value)	
	$TurnLabel.text = "Steps before turn: " + str(value)

func _on_min_slider_changed(value):
	var world = get_node("../")
	# Clamp min so it never exceeds max
	if value > world.room_max_size:
		value = world.room_max_size
		$MinRoom.value = value  # update slider position visually
	world.room_min_size = int(value)
	$RoomLabel.text = "Room size: " + str(world.room_min_size) + " - " + str(world.room_max_size)

func _on_max_slider_changed(value):
	var world = get_node("../")
	# Clamp max so it never goes below min
	if value < world.room_min_size:
		value = world.room_min_size
		$MaxRoom.value = value
	world.room_max_size = int(value)
	$RoomLabel.text = "Room size: " + str(world.room_min_size) + " - " + str(world.room_max_size)
