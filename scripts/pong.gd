extends Area2D

signal miss

@export var speed = 300
var is_moving = false
var is_moving_right = true
var window_size

# Called when the node enters the scene tree for the first time.
func _ready():
	window_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector
	
	if is_moving_right: velocity.x += 1
	else: velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	if position.x > window_size.x - 48 || position.x < 48:
		is_moving_right = !is_moving_right
		miss.emit()
	
	if is_moving:
		position += velocity * delta
		position.x = clamp(position.x, 24, window_size.x - 24)
		position.y = clamp(position.y, 24, window_size.y - 24)

func StartMovement():
	is_moving = true

func _on_area_entered(area):
	if "Paddle" in area.name: 
		is_moving_right = !is_moving_right
