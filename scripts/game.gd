extends Node

@export var p1_score = 0
@export var p2_score = 0

var window_size

# Called when the node enters the scene tree for the first time.
func _ready():
	window_size = get_viewport().get_visible_rect().size
	$Pong.StartMovement()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pong_miss():
	var pong_pos = $Pong.position
	if pong_pos.x > window_size.x - 48: p1_score += 1
	elif pong_pos.x < 48: p2_score += 1
	print("Score: ", p1_score, " - ", p2_score)
	
	$Pong.position = Vector2(320, 240)
	$Pong.visible = false
	$Pong.is_moving = false
	# Show score update in centre
	await get_tree().create_timer(2).timeout
	$"Paddle 1".position = Vector2(48, 240)
	$"Paddle 2".position = Vector2(592, 240)
	await get_tree().create_timer(1).timeout
	$Pong.visible = true
	$Pong.is_moving = true
