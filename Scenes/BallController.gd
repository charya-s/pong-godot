extends CharacterBody2D


# Entity parameters.
@export var _speed = 7.5

# Signals.
signal player_scores
signal enemy_scores
signal ball_reset

# Internal variables.
var direction = Vector2.ZERO

func _ready():
	ResetBall()

func _physics_process(delta):
	velocity = direction * _speed;
	
	var collision = move_and_collide(velocity)
	
	if (collision):
		var collider = collision.get_collider()
		
		if ("Player" in collider.name):
			ProcessPlayerHit(collider)
			
		if ("Enemy" in collider.name):
			ProcessEnemyHit(collider)
			
		if ("Bounds" in collider.name):
			ProcessWallHit(collider)
		
		
func ResetBall():
	var rng = RandomNumberGenerator.new()
	position.x = get_viewport_rect().size.x/2
	# Start a random y-value between 0.25 and 0.75 of the viewport..
	position.y = rng.randf_range(get_viewport_rect().size.y * 0.25, get_viewport_rect().size.y * 0.75) 
	# Move in a random direction at the start (as long as there is x-displacement.
	while (direction.x == 0): 
		direction.x = rng.randi_range(-1, 1)
	direction.y = rng.randi_range(-1, 1)
	ball_reset.emit()
	
# When the player paddle hits the ball, reverse the ball's x-direction and adjust the y-direction
# based on how the player was moving when hitting it.
func ProcessPlayerHit(player):
	direction.x *= -1
	if player.direction != 0:
		direction.y = player.direction
	
# When the enemy paddle hits the ball, reverse the ball's x-direction and adjust the y-direction
# based on how the enemy was moving when hitting it.
func ProcessEnemyHit(enemy):
	direction.x *= -1
	if enemy.direction != 0:
		direction.y = enemy.direction
	
# If the ball hits the upper or lower bounds, it should bounce.
# If the ball hits the left or right bounds, it should go out.
func ProcessWallHit(wall):
	if ("UpDown" in wall.name):
		direction.y *= -1
	
	if ("LeftRight" in wall.name):
		ProcessScoring()
			
# Process scoring and resetting of ball.
func ProcessScoring():
	# Emit scoring signal and send the ball to previous point loser.
	if (position.x < get_viewport_rect().size.x/2):
		enemy_scores.emit()
		direction.x = -1
	else:
		player_scores.emit()
		direction.x = 1
	
	ResetBall()
