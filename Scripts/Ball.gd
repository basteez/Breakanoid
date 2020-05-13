extends RigidBody2D

onready var paddle = get_tree().get_root().get_node("GameScene").find_node("Paddle");
var gameStarted = false;
var startLinearVelocity;
export var ballSpeed = 1000;
func _ready() -> void:
	randomize();
	startLinearVelocity = Vector2(ballSpeed * random_factor(), -ballSpeed)
	linear_velocity = startLinearVelocity;
	print(startLinearVelocity)
	set_mode(RigidBody2D.MODE_KINEMATIC);

func random_factor():
	var random_number = rand_range(-1, 1);
	if(random_number >= 0):
		return 1;
	else:
		return -1;

func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
	if(gameStarted):
		if(linear_velocity.y > 0):
			linear_velocity.y = -startLinearVelocity.y;
		else:
			linear_velocity.y = startLinearVelocity.y;
		if(linear_velocity.x > 0):
			linear_velocity.x = abs(startLinearVelocity.x);
		else:
			linear_velocity.x = -abs(startLinearVelocity.x);

func _physics_process(_delta: float) -> void:
	if(!gameStarted):
		print()
		position.x = paddle.global_position.x;


func _on_Paddle_game_started() -> void:
	if(!self.gameStarted):
		linear_velocity = startLinearVelocity
		set_mode(RigidBody2D.MODE_CHARACTER)
		gameStarted = true;

