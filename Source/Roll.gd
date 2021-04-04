extends Button


# Declare member variables here. Examples:
var current_nodes = []
var available_nodes = []
var rolled_nodes = []
var rng = RandomNumberGenerator.new()

var current_resource


# Called when the node enters the scene tree for the first time.
func _ready():
	var fire_gem = {
		name = "Fire Gem",
		value = 1
	}
	var empty = {
		name = "Empty",
		value = 0
	}
	for i in range(5):
		current_nodes.append(fire_gem)
	for i in range(20):
		current_nodes.append(empty)
	rng.randomize()
	
	# Start with no resource
	current_resource = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func roll_node():
	if available_nodes.size() == 0:
		return {
			name = "Empty",
			value = 0
		}
	var node_index_generated = rng.randi_range(0, available_nodes.size() - 1)
	var node_rolled = available_nodes[node_index_generated]
	available_nodes.remove(node_index_generated)
	return node_rolled

func _on_Button_pressed():
	# Reset the pool of avaliable nodes
	available_nodes = current_nodes.duplicate()
	available_nodes.shuffle()
	
	# Roll on each node
	rolled_nodes.clear()
	for index in range(25):
		rolled_nodes.append(roll_node())
	
	# Display the rolled nodes
	var spin_nodes = get_parent().get_node("Spin_Board").get_children()
	var spin_node_count = 0
	for spin_node in spin_nodes:
		var roll_text = ""
		for index in range(5):
			roll_text += rolled_nodes[spin_node_count * 5 + index].name
			if index != 4:
				roll_text += "\n"
		spin_node.text = roll_text
		spin_node_count += 1
		
	# Calculate any boosts nodes would gain
	# TODO
		
	# Calculate resource gain from roll
	var resource_gained = 0
	for node in rolled_nodes:
		resource_gained += node.value
	
	current_resource += resource_gained
	
	# Display current resource
	var resource_display = get_parent().get_node("Resource")
	resource_display.text = str(current_resource)
	
	pass # Replace with function body.
