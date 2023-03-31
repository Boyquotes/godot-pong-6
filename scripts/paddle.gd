extends Area2D

@export var speed = 400
@export var is_player_one: bool
@export var is_only_player: bool
var action_names = Array()
var window_size

# Called when the node enters the scene tree for the first time.
func _ready():
	window_size = get_viewport_rect().size
	if is_only_player:
		action_names = ["move_down_one", "move_up_one", "move_down_two", "move_up_two"]
	else: 
		if is_player_one:
			action_names = ["move_down_one", "move_up_one", "move_down_one", "move_up_one"]
		else:
			action_names = ["move_down_two", "move_up_two", "move_down_two", "move_up_two"]
		# FIXME duplicates are inefficient

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector
	if Input.is_action_pressed(action_names[0]) || Input.is_action_pressed(action_names[2]):
		velocity.y += 1
	if Input.is_action_pressed(action_names[1]) || Input.is_action_pressed(action_names[3]):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.y = clamp(position.y, 72, window_size.y - 72)

